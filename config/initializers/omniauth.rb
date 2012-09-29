Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, '96c02529b18a2a9961c5', '6f37b3f9b88094b090da4a7e677c8bad5c5a1380', scope: "user,repo"
end