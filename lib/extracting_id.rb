require 'extracting_id/version'


module ExtractingId
  class Core
    def initialize
    end
    def main(storyboardFile, output_dir, fileName = "ExtactedID")
      readFile = self.fileRead(storyboardFile)
      arrayString = scan(readFile)
      arrType = self.exchange(arrayString)
      header = self.header(arrType, fileName)
      fileWrite(output_dir)
    end

    def fileRead(fileName)
      File.open(fileName,  :mode => "rb", :encoding => "UTF-8").read
    end
    def scan(readFile)
      readFile.scan(/(.*)\n/).flatten
    end
    def exchange(arrStr)
      arrStr.map{|s| to_class(s) }.flatten.inject([]){|a, s|
        if a.index(s) == nil then
          a.push(s)
        end
        a
      }
    end
    def to_class(s)
      if / identifier="(\w+)" / =~ s then
        [Segue.new($1)]
      elsif / restorationIdentifier="(\w+)" / =~ s then
        [Restore.new($1)]
      elsif /storyboardIdentifier="(\w+)"/ =~ s then
        [Storyboard.new($1)]
      else
        []
      end
    end
    def header(arrType, fileName)
      self.define(arrType)
    end
    def define(arrType)
      arrType.map{|s| s.impDefine}.inject(""){|s, i| s + i}
    end
    def fileWrite(output_dir)
      head = "#{output_dir}#{fileName}.h"
      FileUtils.mkdir_p(output_dir) unless FileTest.exist?(output_dir)
      File.open(head, "w:UTF-8"){|f|
        f.write header
      }
    end
  end
  class Type
    def initialize(name)
      @name = name
    end
    def == (type)
      @name == type.name
    end
    def name
      @name
    end
    def capitalize
      c = @name
      c[0,1].capitalize + c[1..-1]
    end
    def define
      "k" + self.class_name + self.capitalize
    end
    def nsString
      '@"' + @name + '"'
    end
    def impDefine
      "\#define #{self.define} #{self.nsString}\n"
    end
  end
  class Segue < Type
    def class_name
      "Segue"
    end
    def == (type)
      Segue === type && super(type)
    end
  end
  class Restore < Type
    def class_name
      "Restore"
    end
    def == (type)
      Restore === type && super(type)
    end
  end
  class Storyboard < Type
    def class_name
      "Storyboard"
    end
    def == (type)
      Storyboard === type && super(type)
    end
  end
end
