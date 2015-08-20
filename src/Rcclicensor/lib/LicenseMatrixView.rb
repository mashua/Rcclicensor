require_relative 'LicenseView'

#subclass the FXMatrix Layout!
class LicenseMatrixView < FXMatrix
  
  attr_accessor :theIconsPath
  
  def initialize( theParent, iconsPath  )
    
    @theIconsPath = iconsPath;
    #call parent constructor
    super(theParent, :opts=> LAYOUT_FILL || MATRIX_BY_COLUMNS);
    
  end
  
  def load_licenses(  )
    
#    puts self.theIconsPath
    
    #the directory to return after we finish licenses-icon polling
    oldir = Dir.pwd;    
    iconFiles = Dir.chdir( @theIconsPath ); #go to the licenses directory
    iconFiles = Dir.glob("*.{png,jpg,jpeg,tiff,ico }") ;
    Dir.chdir(oldir) ; # go to the previous directory
    puts iconFiles;
    
    test = LicenseView.new( self, "../../../img/icons/by.png" );
#    by_check = FXCheckButton.new( self, '') ;
#      by_icon = FXPNGIcon.new( app, File.open("../../../img/icons/by.png","rb").read );
#    by_icon_label = FXLabel.new( self, "BY" ,  :icon => by_icon);
#    
#    cc_check = FXCheckButton.new( self, '') ;
#      cc_icon = FXPNGIcon.new( app, File.open("../../../img/icons/cc.png","rb").read );
#    cc_icon_label = FXLabel.new( self, "CC" , :icon => cc_icon);
#    
#    nc_check = FXCheckButton.new( self, '') ;
#      nc_icon = FXPNGIcon.new( app, File.open("../../../img/icons/nc.png","rb").read );
#    nc_icon_label = FXLabel.new( self, "NC" , :icon => nc_icon);
#    
#    nc_eu_check = FXCheckButton.new( self, '') ;
#      nc_eu_icon = FXPNGIcon.new( app, File.open("../../../img/icons/nc-eu.png","rb").read );
#    nc_eu_icon_label = FXLabel.new( self, "NC-EU" , :icon => nc_eu_icon);
#    
#    nc_jp_check = FXCheckButton.new( self, '') ;
#      nc_jp_icon = FXPNGIcon.new( app, File.open("../../../img/icons/nc-jp.png","rb").read );
#    nc_jp_icon_label = FXLabel.new( self, "NC-JP" , :icon => nc_jp_icon);
#    
#    nd_check = FXCheckButton.new( self, '') ;
#      nd_icon = FXPNGIcon.new( app, File.open("../../../img/icons/nd.png","rb").read );
#    nd_icon_label = FXLabel.new( self, "ND" , :icon => nd_icon);
  end
  
end
