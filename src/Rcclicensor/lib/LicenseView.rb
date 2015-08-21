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
  attr_accessor :theIcon; #this is to be of type unknown
  attr_accessor :theFXLabel;
  attr_accessor :theIconFilepath;
  
  #
  #Params:
  #+theParent+::
  #++iconfilepath+::something like: "../../../icons/test.ico"
  def initialize( theParent, iconfilepath )
    
    @theIconFilepath = iconfilepath;
    super( theParent, :opts=>LAYOUT_FILL );
    @theFXCheckbutton = FXCheckButton.new( self, '');    
    
    puts "the path is " + iconfilepath;
#    widgetype = iconfilepath.index(/[a-zA-Z^\/][a-zA-Z]/); #[^\\]*\.(\w+)$ [^\\]*\.(\w+)$
#    widgetype = iconfilepath.index(/[^\/^\\]*(\w+)$/);

    fnwt = iconfilepath[/[^\/^\\]*(\w+)$/].split(/[\.]/); #regex to match the filename.extension and then split them to
                                                               #take the filename and extension.

    case
    when fnwt[1] == "png"
      @theIcon = FXPNGIcon.new( app, File.open( theIconFilepath ,"rb").read); #or use self.theIconFilepath
    when fnwt[1] == "bmp"
      @theIcon = FXBMPIcon.new( app, File.open( theIconFilepath ,"rb").read); #or use self.theIconFilepath
    when fnwt[1] == "gif"
      @theIcon = FXGIFIcon.new( app, File.open( theIconFilepath ,"rb").read); #or use self.theIconFilepath
    when fnwt[1] == "ico"
      @theIcon = FXICOIcon.new( app, File.open( theIconFilepath ,"rb").read); #or use self.theIconFilepath  
    when fnwt[1] == "jpg"
      @theIcon = FXJPGIcon.new( app, File.open( theIconFilepath ,"rb").read); #or use self.theIconFilepath
    when fnwt[1] == "pcx"
      @theIcon = FXPCXIcon.new( app, File.open( theIconFilepath ,"rb").read); #or use self.theIconFilepath
    when fnwt[1] == "ppm"
      @theIcon = FXPPMIcon.new( app, File.open( theIconFilepath ,"rb").read); #or use self.theIconFilepath  
    when fnwt[1] == "rgb"
      @theIcon = FXRGBIcon.new( app, File.open( theIconFilepath ,"rb").read); #or use self.theIconFilepath
    when fnwt[1] == "tga"
      @theIcon = FXTGAIcon.new( app, File.open( theIconFilepath ,"rb").read); #or use self.theIconFilepath  
    when fnwt[1] == "tif"
      @theIcon = FXTIFIcon.new( app, File.open( theIconFilepath ,"rb").read); #or use self.theIconFilepath  
    when fnwt[1] == "xbm"
      @theIcon = FXXBMIcon.new( app, File.open( theIconFilepath ,"rb").read); #or use self.theIconFilepath  
    when fnwt[1] == "xpm"
      @theIcon = FXXPMIcon.new( app, File.open( theIconFilepath ,"rb").read); #or use self.theIconFilepath  
    end
   
    
    @theFXLabel = FXLabel.new( self, "BY", :icon => @theIcon );    
    
  end
    
end
