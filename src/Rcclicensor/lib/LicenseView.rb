
class LicenseView < FXHorizontalFrame
  
  attr_accessor :theFXCheckbutton;  
  attr_accessor :theFXPNGIcon;
  attr_accessor :theFXLabel;
  attr_accessor :theIconFilepath;
  
  def initialize( theParent, iconfilepath )
    
    @theIconFilepath = iconfilepath;
    super( theParent, :opts=>LAYOUT_FILL );
    
    @theFXCheckbutton = FXCheckButton.new( self, '');    
    puts "##"
    puts theIconFilepath;
    @theFXPNGIcon = FXPNGIcon.new( app, File.open( theIconFilepath ,"rb").read); #or use self.theIconFilepath
    @theFXLabel = FXLabel.new( self, "BY", :icon => @theFXPNGIcon );    
    
  end
    
end
