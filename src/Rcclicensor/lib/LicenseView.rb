#Create a new license-specific icon/image.
#The license is created by reading the filename, and then creating
#the appropriate widget.
#Supported types are:
#FXBMPIcon, FXGIFIcon, FXICOIcon, FXJPGIcon, FXPCXIcon, FXPNGIcon, FXPPMIcon, FXRGBIcon, FXTGAIcon, FXTIFIcon, FXXBMIcon, FXXPMIcon
#Example:
#With a filename of test.png,
#the created widget will be a FXPNGIcon and the label will read: 'test'
#Params:
#+the newly created license's widget parent+::
#+the path to the icon/image+::
class LicenseView < FXHorizontalFrame
  
  attr_accessor :theFXCheckbutton;  
  attr_accessor :theIcontheIcon; #this is to be of type unknown
  attr_accessor :theFXLabel;
  attr_accessor :theIconFilepath;
  
  #
  #Params:
  #+theParent+::
  #++iconfilepath+::something like: "../test.icon"
  def initialize( theParent, iconfilepath )
    
    @theIconFilepath = iconfilepath;
    super( theParent, :opts=>LAYOUT_FILL );
    
    @theFXCheckbutton = FXCheckButton.new( self, '');    
    puts "##"
    puts theIconFilepath;
    @theIcon = FXPNGIcon.new( app, File.open( theIconFilepath ,"rb").read); #or use self.theIconFilepath
    @theFXLabel = FXLabel.new( self, "BY", :icon => @theIcon );    
    
  end
    
end
