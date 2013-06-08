$count = 0
$success = 0
$testFile = "TestStoryboard.storyboard"
$/
require 'extractingId'

def test (obj , result)
  if obj != result then
    p obj
    p " is not "
    p result
  elsif
      $success = $success + 1
  end
  $count = $count + 1
end
def endTest ()
    puts ""
    puts "#{$success} / #{$count} Test"
end
    

user = UserDefualts.new
str = user.exchange(user.fileRead($testFile))
test(str, [
     Storyboard.new("HogeMoge"),
     Restore.new("Cell"),
     Segue.new("Edit"),
     Segue.new("Back"),
])

define = str.map{|s| s.define}
test(define, [
     "kStoryboardHogeMoge",
     "kRestoreCell",
     "kSegueEdit",
     "kSegueBack",
])

define = str.map{|s| s.impDefine}
test(define, [
     "\#define kStoryboardHogeMoge @\"HogeMoge\"\n",
     "\#define kRestoreCell @\"Cell\"\n",
     "\#define kSegueEdit @\"Edit\"\n",
     "\#define kSegueBack @\"Back\"\n",
])


endTest()