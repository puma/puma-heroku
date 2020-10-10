Puma::Plugin.create do
  def config(c)
    c.port        ENV['PORT']     || 3000
  end

  VERSION = "2.0.0"
end
