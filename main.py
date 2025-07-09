import sys
import clips
from PySide6.QtWidgets import QApplication, QWidget, QVBoxLayout, QPushButton, QLabel
from PySide6.QtCore import Qt

global environment

def main():
    global environment
    environment = clips.Environment()
    environment.load("website.clp")
    environment.reset()
    environment.run()
    app = QApplication()
    window = Website()
    window.resize(400, 400)
    window.show()
    sys.exit(app.exec())

class Website(QWidget):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Website idea")

        self.q = ""
        self.a = []
        self.s = ""

        self.layout = QVBoxLayout()
        self.label = QLabel("")
        self.label.setAlignment(Qt.AlignCenter)
        self.layout.addWidget(self.label)

        self.update_values()
        self.create_buttons()

        self.setLayout(self.layout)

    def update_values(self):
        for fact in environment.facts():
            if fact.template.name == "qview":
                self.q = fact["question"]
                self.a = list(fact["answers"])
                self.s = fact["shortname"]
                break
        self.label.setText(self.q)

    def create_buttons(self):
        for i in reversed(range(self.layout.count())):
            widget = self.layout.itemAt(i).widget()
            if widget is not self.label:
                widget.deleteLater()

        for button_text in self.a:
            button = QPushButton(button_text)
            button.clicked.connect(self.button_clicked)
            self.layout.addWidget(button)

    def button_clicked(self):
        button = self.sender()
        answer = button.text()
        print(answer)
        if answer == "Finish":
            QApplication.quit()
            return
        environment.assert_string(f'({self.s} "{answer}")')
        environment.run()
        self.update_values()
        self.create_buttons()


if __name__ == "__main__":
    main()
