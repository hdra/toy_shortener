default: init
init:
	@mix deps.get
	@(cd assets && npm install)
	@mix compile
	@mix ecto.create
	@mix ecto.migrate
serve:
	@mix phx.server
