(deftemplate qview
	(slot question (type STRING))
	(multislot answers (type STRING))
	(slot shortname (type SYMBOL))
)

(defrule start
	(not (exists (qview (shortname start))))
	(not (exists (start ?)))
=>
	(assert (qview
			(question "Awesome website idea system")
			(answers "Start")
			(shortname start)
		)
	)
)

(defrule awesome_idea
	?q <- (qview)
	(start "Start")
	(not (exists (qview (shortname awesome_idea))))
	(not (exists (awesome_idea ?)))
=>
	(retract ?q)
	(assert (qview
			(question "So you've got an awesome idea for a website?")
			(answers "Sure do!" "Nope")
			(shortname awesome_idea)
		)
	)
)

(defrule awesome_idea_2
	?q <- (qview)
	?a <- (awesome_idea "Sure do!")
	?b <- (any_web_skills "Nope")
	?c <- (willing_to_learn "Nope")
	?d <- (hire_someone "Nope")
	?e <- (any_other_skills "Yeah I do!")
	?f <- (what_skills "I have great ideas")
	(not (exists (qview (shortname awesome_idea))))
=>
	(retract ?q)
	(retract ?a)
	(retract ?b)
	(retract ?c)
	(retract ?d)
	(retract ?e)
	(retract ?f)
	(assert (qview
			(question "So you've got an awesome idea for a website?")
			(answers "Sure do!" "Nope")
			(shortname awesome_idea)
		)
	)
)

(defrule noidea_nodice
	?q <- (qview)
	(awesome_idea "Nope")
	(not (exists (qview (shortname noidea_nodice))))
=>
	(retract ?q)
	(assert (qview
			(question "No idea, no dice")
			(answers "Finish")
			(shortname noidea_nodice)
		)
	)
)

(defrule any_web_skills
	?q <- (qview)
	(awesome_idea "Sure do!")
	(not (exists (qview (shortname any_web_skills))))
	(not (exists (any_web_skills ?)))
=>
	(retract ?q)
	(assert (qview
			(question "Do you have any web-related skills?")
			(answers "Yeah totally" "I know a little dreamveawer!" "Nope")
			(shortname any_web_skills)
		)
	)
)

(defrule old_school
	?q <- (qview)
	(or
		(any_web_skills "I know a little dreamveawer!")
		(how_development "I know ASP.NET")
		(how_design "Microsoft front page")
		(how_social "I have 47 friends on Myspace")
	)
	(not (exists (qview (shortname old_school))))
=>
	(retract ?q)
	(assert (qview
			(question "Whoa old school! Sounds like it's time to update")
			(answers "Finish")
			(shortname old_school)
		)
	)
)

(defrule willing_to_learn
	?q <- (qview)
	(any_web_skills "Nope")
	(not (exists (qview (shortname willing_to_learn))))
	(not (exists (willing_to_learn ?)))
=>
	(retract ?q)
	(assert (qview
			(question "Are you willing to learn?")
			(answers "Yeah totally" "Nope")
			(shortname willing_to_learn)
		)
	)
)

(defrule hire_someone
	?q <- (qview)
	(willing_to_learn "Nope")
	(not (exists (qview (shortname hire_someone))))
	(not (exists (hire_someone ?)))
=>
	(retract ?q)
	(assert (qview
			(question "Are you looking to hire someone?")
			(answers "Yes" "Nope")
			(shortname hire_someone)
		)
	)
)

(defrule any_other_skills
	?q <- (qview)
	(hire_someone "Nope")
	(not (exists (qview (shortname any_other_skills))))
	(not (exists (any_other_skills ?)))
=>
	(retract ?q)
	(assert (qview
			(question "Do you have any other skills?")
			(answers "Yeah I do!" "I have a lot of friends" "Nope")
			(shortname any_other_skills)
		)
	)
)

(defrule what_are_u_doing
	?q <- (qview)
	(any_other_skills "Nope")
	(not (exists (qview (shortname what_are_u_doing))))
=>
	(retract ?q)
	(assert (qview
			(question "What are you doing here, anyway?")
			(answers "Finish")
			(shortname what_are_u_doing)
		)
	)
)

(defrule what_skills
	?q <- (qview)
	(any_other_skills "Yeah I do!")
	(not (exists (qview (shortname what_skills))))
	(not (exists (what_skills ?)))
=>
	(retract ?q)
	(assert (qview
			(question "What kind of skills?")
			(answers "I have great ideas" "I majored in art history..." "I make a wicked martini")
			(shortname what_skills)
		)
	)
)

(defrule bartender
	?q <- (qview)
	(what_skills ~"I have great ideas")
	(not (exists (qview (shortname bartender))))
=>
	(retract ?q)
	(assert (qview
			(question "Well, the Web isn't for everyone, you'd make a great bartender")
			(answers "Finish")
			(shortname bartender)
		)
	)
)

(defrule any_developers
	?q <- (qview)
	(any_other_skills "I have a lot of friends")
	(not (exists (qview (shortname any_developers))))
	(not (exists (any_developers ?)))
=>
	(retract ?q)
	(assert (qview
			(question "Are any of them web developers?")
			(answers "Yes" "Nope")
			(shortname any_developers)
		)
	)
)

(defrule following_tumblr
	?q <- (qview)
	(any_developers "Nope")
	(not (exists (qview (shortname following_tumblr))))
	(not (exists (following_tumblr ?)))
=>
	(retract ?q)
	(assert (qview
			(question "Are 40 friends following your tumblr?")
			(answers "Yes" "Still no")
			(shortname following_tumblr)
		)
	)
)

(defrule will_be_friend
	?q <- (qview)
	(following_tumblr "Still no")
	(not (exists (qview (shortname will_be_friend))))
=>
	(retract ?q)
	(assert (qview
			(question "We'll be your friend...")
			(answers "Finish")
			(shortname will_be_friend)
		)
	)
)

(defrule connector
	?q <- (qview)
	(or
		(hire_someone "Yes")
		(any_developers "Yes")
		(following_tumblr "Yes")
	)
	(not (exists (qview (shortname connector))))
=>
	(retract ?q)
	(assert (qview
			(question "You're a connector, time to find the right team")
			(answers "Finish")
			(shortname connector)
		)
	)
)

(defrule what_plan
	?q <- (qview)
	(willing_to_learn "Yeah totally")
	(not (exists (qview (shortname what_plan))))
	(not (exists (what_plan ?)))
=>
	(retract ?q)
	(assert (qview
			(question "So what's your plan?")
			(answers "Gonna fake it till I make it!" "Get another degree" "Dive in and learn something new")
			(shortname what_plan)
		)
	)
)

(defrule are_you_lucky
	?q <- (qview)
	(what_plan "Gonna fake it till I make it!")
	(not (exists (qview (shortname are_you_lucky))))
	(not (exists (are_you_lucky ?)))
=>
	(retract ?q)
	(assert (qview
			(question "Are you extremely lucky?")
			(answers "Yes" "Nope")
			(shortname are_you_lucky)
		)
	)
)

(defrule are_you_wealthy
	?q <- (qview)
	(are_you_lucky "Nope")
	(not (exists (qview (shortname are_you_wealthy))))
	(not (exists (are_you_wealthy ?)))
=>
	(retract ?q)
	(assert (qview
			(question "Are you extremely wealthy?")
			(answers "Yes" "Nope")
			(shortname are_you_wealthy)
		)
	)
)

(defrule are_you_good
	?q <- (qview)
	(are_you_wealthy "Nope")
	(not (exists (qview (shortname are_you_good))))
	(not (exists (are_you_good ?)))
=>
	(retract ?q)
	(assert (qview
			(question "Are you extremely good-looking?")
			(answers "Yes" "Nope")
			(shortname are_you_good)
		)
	)
)

(defrule surgeon
	?q <- (qview)
	(are_you_good "Nope")
	(not (exists (qview (shortname surgeon))))
=>
	(retract ?q)
	(assert (qview
			(question "Let me get you the number for my plastic surgeon")
			(answers "Finish")
			(shortname surgeon)
		)
	)
)

(defrule gonna_be_huge
	?q <- (qview)
	(or
		(are_you_lucky "Yes")
		(are_you_wealthy "Yes")
		(are_you_good "Yes")
	)
	(not (exists (qview (shortname gonna_be_huge))))
=>
	(retract ?q)
	(assert (qview
			(question "You're gonna be huge, time to hire some people")
			(answers "Finish")
			(shortname gonna_be_huge)
		)
	)
)

(defrule grad_school
	?q <- (qview)
	(what_plan "Get another degree")
	(not (exists (qview (shortname grad_school))))
	(not (exists (grad_school ?)))
=>
	(retract ?q)
	(assert (qview
			(question "Do you have $80k to blow on grad school?")
			(answers "You know it" "Not quite")
			(shortname grad_school)
		)
	)
)

(defrule community_college
	?q <- (qview)
	(grad_school "Not quite")
	(not (exists (qview (shortname community_college))))
	(not (exists (community_college ?)))
=>
	(retract ?q)
	(assert (qview
			(question "Do you have $30k to blow on community college?")
			(answers "Yeah totally cha-ching!" "Still no")
			(shortname community_college)
		)
	)
)

(defrule continue_certificate
	?q <- (qview)
	(community_college "Still no")
	(not (exists (qview (shortname continue_certificate))))
	(not (exists (continue_certificate ?)))
=>
	(retract ?q)
	(assert (qview
			(question "Do you have $8k to blow on a continuing ed certificate?")
			(answers "That, I can handle!" "I live with mom")
			(shortname continue_certificate)
		)
	)
)

(defrule rich_uncle
	?q <- (qview)
	(continue_certificate "I live with mom")
	(not (exists (qview (shortname rich_uncle))))
=>
	(retract ?q)
	(assert (qview
			(question "Find your rich uncle, tell him he's always been your favorite")
			(answers "Finish")
			(shortname rich_uncle)
		)
	)
)

(defrule see_you_in_years
	?q <- (qview)
	(or
		(grad_school "You know it")
		(community_college "Yeah totally cha-ching!")
		(continue_certificate "That, I can handle!")
	)
	(not (exists (qview (shortname see_you_in_years))))
=>
	(retract ?q)
	(assert (qview
			(question "See you in a couple years! Hopefully the Internet still exists.")
			(answers "Finish")
			(shortname see_you_in_years)
		)
	)
)

(defrule what_to_learn
	?q <- (qview)
	(what_plan "Dive in and learn something new")
	(not (exists (qview (shortname what_to_learn))))
	(not (exists (what_to_learn ?)))
=>
	(retract ?q)
	(assert (qview
			(question "What are you going to learn?")
			(answers "Learn Web development" "Learn Web design" "Learn social strategy")
			(shortname what_to_learn)
		)
	)
)

(defrule how_development
	?q <- (qview)
	(what_to_learn "Learn Web development")
	(not (exists (qview (shortname how_development))))
	(not (exists (how_development ?)))
=>
	(retract ?q)
	(assert (qview
			(question "How exactly?")
			(answers "I know ASP.NET" "Learn Ruby on rails")
			(shortname how_development)
		)
	)
)

(defrule how_design
	?q <- (qview)
	(what_to_learn "Learn Web design")
	(not (exists (qview (shortname how_design))))
	(not (exists (how_design ?)))
=>
	(retract ?q)
	(assert (qview
			(question "How exactly?")
			(answers "Microsoft front page" "Learn Photoshop & CSS")
			(shortname how_design)
		)
	)
)

(defrule how_social
	?q <- (qview)
	(what_to_learn "Learn social strategy")
	(not (exists (qview (shortname how_social))))
	(not (exists (how_social ?)))
=>
	(retract ?q)
	(assert (qview
			(question "How exactly?")
			(answers "I have 47 friends on Myspace" "Get mentioned on Mashable")
			(shortname how_social)
		)
	)
)

(defrule what_can_u_do
	?q <- (qview)
	(any_web_skills "Yeah totally")
	(not (exists (qview (shortname what_can_u_do))))
	(not (exists (what_can_u_do ?)))
=>
	(retract ?q)
	(assert (qview
			(question "What can you do?")
			(answers "I can code!" "I can design!" "I'm a social genius!")
			(shortname what_can_u_do)
		)
	)
)

(defrule you_are_ready
	?q <- (qview)
	(or
		(what_can_u_do ?)
		(how_development "Learn Ruby on rails")
		(how_design "Learn Photoshop & CSS")
		(how_social "Get mentioned on Mashable")
	)
	(not (exists (qview (shortname you_are_ready))))
	(not (exists (you_are_ready ?)))
=>
	(retract ?q)
	(assert (qview
			(question "Sweet! You're ready to build a site!")
			(answers "Nice!")
			(shortname you_are_ready)
		)
	)
)

(defrule hold_it
	?q <- (qview)
	(you_are_ready "Nice!")
	(not (exists (qview (shortname hold_it))))
	(not (exists (hold_it ?)))
=>
	(retract ?q)
	(assert (qview
			(question "Hold it. Just cuz ya got the skills, doesn't mean ya got the chops")
			(answers "Huh?")
			(shortname hold_it)
		)
	)
)

(defrule idea_of_code
	?q <- (qview)
	(hold_it "Huh?")
	(not (exists (qview (shortname idea_of_code))))
	(not (exists (idea_of_code ?)))
=>
	(retract ?q)
	(assert (qview
			(question "What's your idea of good code?")
			(answers "Naming variables after my pets" "Scalable, well-commented, seamlessly integrated" "Lots and lots of nested tables" "Copy and paste from Stack Overflow")
			(shortname idea_of_code)
		)
	)
)

(defrule need_a_dev
	?q <- (qview)
	(idea_of_code ~"Scalable, well-commented, seamlessly integrated")
	(not (exists (qview (shortname need_a_dev))))
=>
	(retract ?q)
	(assert (qview
			(question "Yeah, you're gonna need a developer")
			(answers "Finish")
			(shortname need_a_dev)
		)
	)
)

(defrule idea_of_design
	?q <- (qview)
	(idea_of_code "Scalable, well-commented, seamlessly integrated")
	(not (exists (qview (shortname idea_of_design))))
	(not (exists (idea_of_design ?)))
=>
	(retract ?q)
	(assert (qview
			(question "Great, what's your idea of good design?")
			(answers "Rounded corners and plenty of gloss" "The more fonts, the merrier" "Clear hierarchy, beautiful interactions, thoughtful styling" "I dream of geocities" "Starbursts and drop shadows")
			(shortname idea_of_design)
		)
	)
)

(defrule no_photoshop
	?q <- (qview)
	(idea_of_design ~"Clear hierarchy, beautiful interactions, thoughtful styling")
	(not (exists (qview (shortname no_photoshop))))
=>
	(retract ?q)
	(assert (qview
			(question "We're not letting you anywhere near Photoshop")
			(answers "Finish")
			(shortname no_photoshop)
		)
	)
)

(defrule idea_of_social
	?q <- (qview)
	(idea_of_design "Clear hierarchy, beautiful interactions, thoughtful styling")
	(not (exists (qview (shortname idea_of_social))))
	(not (exists (idea_of_social ?)))
=>
	(retract ?q)
	(assert (qview
			(question "Great, what's your idea of good social media strategy?")
			(answers "Making lots of Twitter accounts to retweet myself" "Building engaging conversation around your launch" "Just fill every page with share buttons" "Finding and seeding brand content in appropriate channels" "Spamming followers with sponsored links")
			(shortname idea_of_social)
		)
	)
)

(defrule you_dont_know
	?q <- (qview)
	(idea_of_social "Making lots of Twitter accounts to retweet myself"|"Just fill every page with share buttons"|"Spamming followers with sponsored links")
	(not (exists (qview (shortname you_dont_know))))
=>
	(retract ?q)
	(assert (qview
			(question "We're not convinced you know what social media is")
			(answers "Finish")
			(shortname you_dont_know)
		)
	)
)

(defrule you_look_great
	?q <- (qview)
	(idea_of_social "Building engaging conversation around your launch"|"Finding and seeding brand content in appropriate channels")
	(not (exists (qview (shortname you_look_great))))
=>
	(retract ?q)
	(assert (qview
			(question "You look great! Go forth with your website, brave one!")
			(answers "Finish")
			(shortname you_look_great)
		)
	)
)