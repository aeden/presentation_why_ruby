!SLIDE

#Error Handling#

!SLIDE

    @@@ruby
    # raise an error 
    class Person
      def do_something
        raise "I refuse to do it"
      end
    end
    person = Person.new
    person.do_something

!SLIDE

    @@@ruby
    # rescue from an error
    begin
      person.do_something
    rescue => e
      "the person didn't do what we asked: #{e}"
    end

!SLIDE

    @@@ruby
    # rescue from an error as
    # part of a method block
    class Person
      def catch_an_error
        raise "an error"
      rescue => e
        "an error was raised"
      end
    end
    person = Person.new
    person.catch_an_error

!SLIDE

    @@@ruby
    # ensure
    f = File.open('/etc/resolv.conf')
    begin
      p f.read
    rescue => e
      puts "error: #{e}"
    ensure
      f.close if f
    end

!SLIDE

    @@@ruby
    # even better
    begin
      File.open('/etc/resolv.conf') do |f|
        p f.read
      end
    rescue => e
      puts "error: #{e}"
    end
