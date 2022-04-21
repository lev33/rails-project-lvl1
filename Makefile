install: 
	bundle install

lint:
	bundle exec rubocop .

correct:
	bundle exec rubocop -A .

test:
	rake test
