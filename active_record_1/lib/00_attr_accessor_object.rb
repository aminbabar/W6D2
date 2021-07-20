class AttrAccessorObject


  

  def self.my_attr_accessor(*names)


    names.each do |name|
      define_method(name) do
        s = "@" + name.to_s
        self.instance_variable_get(s)
      end

      arg1 = name.to_s + '='
      define_method(arg1) do |arg|
        s = "@" + name.to_s
        self.instance_variable_set(s, arg)
      end
    end

  end

end









# class Example
#   # attr_accessor :foo, :bar
#   def initialize()
#     @foo = "foo"
#     @bar = "bar"
#   end

#   # def foo
#   #   @foo
#   # end

#   # def foo=(value)
#   #   @foo = value
#   # end


# end

# # a = Example.new()
# # p a.instance_variable_get(:@foo)



