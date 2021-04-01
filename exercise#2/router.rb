module Resource
  def connection(routes)
    if routes.nil?
      puts "No route matches for #{self}"
      return
    end

    loop do
      print 'Choose verb to interact with resources (GET/POST/PUT/DELETE) / q to exit: '
      verb = gets.chomp
      break if verb == 'q'

      action = nil

      if verb == 'GET'
        print 'Choose action (index/show) / q to exit: '
        action = gets.chomp
        break if action == 'q'
      end


      action.nil? ? routes[verb].call : routes[verb][action].call
    end
  end
end

# Получение введенного значения
def inputWithCondition (str, is_int)
  if is_int
    print "Enter #{str}: "
    value = gets.to_i
  else
    print "Enter #{str}: "
    value = gets.chomp
    value.upcase
  end
  value
end


class CommentsController
  extend Resource

  def initialize
    @comments = []
  end

  def index
    @comments.each_with_index do |comment, index|
      print index
      print " : "
      print comment[0]
      print " : "
      puts comment[1]
    end
  end

  def show()
    i = inputWithCondition("comment index", true)
    @comments.each_with_index do |comment, index|
      if i == index
        print index
        print " : "
        print comment[0]
        print " : "
        puts comment[1]
      end
    end
  end

  def create()
    post_i = inputWithCondition("post index", true)
    str = inputWithCondition("comment text", false)
    @comments.push([post_i, str])
    print @comments.index(@comments.last)
    print " : "
    print @comments.last[0]
    print " : "
    puts @comments.last[1]
  end

  def update()
    i = inputWithCondition("comment index", true)
    str = inputWithCondition("comment text", false)
    @comments[i] = str
    @comments.each_with_index do |comment, index|
      if i == index
        print index
        print " : "
        print comment[0]
        print " : "
        puts comment[1]
      end
    end
  end

  def destroy()
    i = inputWithCondition("comment index", true)
    @comments.delete_at(i)
  end
end

class PostsController
  extend Resource

  def initialize
    @posts = []
  end

  def index
    @posts.each_with_index do |post, index|
      print index
      print " : "
      puts post
    end
  end

  def show()
    i = inputWithCondition("post index", true)
    @posts.each_with_index do |post, index|
      if i == index
        print index
        print " : "
        puts post
      end
    end
  end

  def create()
    str = inputWithCondition("post text", false)
    @posts.push(str)
    print @posts.index(@posts.last)
    print " : "
    puts @posts.last
  end

  def update()
    i = inputWithCondition("post index", true)
    str = inputWithCondition("post text", false)
    @posts[i] = str
    @posts.each_with_index do |post, index|
      if i == index
        print index
        print " : "
        puts post
      end
    end
  end

  def destroy()
    i = inputWithCondition("post index", true)
    @posts.delete_at(i)
  end
end

class Router
  def initialize
    @routes = {}
  end

  def init
    resources(PostsController, 'posts')
    resources(CommentsController, 'comments')

    loop do
      print 'Choose resource you want to interact (1 - Posts, 2 - Comments, q - Exit): '
      choise = gets.chomp

      PostsController.connection(@routes['posts']) if choise == '1'
      CommentsController.connection(@routes['comments']) if choise == '2'
      break if choise == 'q'
    end

    puts 'Good bye!'
  end

  def resources(klass, keyword)
    controller = klass.new
    @routes[keyword] = {
      'GET' => {
        'index' => controller.method(:index),
        'show' => controller.method(:show)
      },
      'POST' => controller.method(:create),
      'PUT' => controller.method(:update),
      'DELETE' => controller.method(:destroy)
    }
  end
end

router = Router.new

router.init
