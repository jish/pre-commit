# Some examples of ruby1.8 old style hash rocket

gem 'foo', :ref => 'v2.6.0'
{ :'foo-bar' => 42 } #It's ok to use hashrockets for a symbolized string
{ :@test => "foo_bar" }
{ :_test => "foo_bar" }
{ :$test => "foo_bar" }
{ :test! => "foo_bar" }
{ :test? => "foo_bar" }
{ :test= => "foo_bar" }
{ :@@test => "foo_bar" }
