# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

class LicenseMatrixView < FXMatrix
  
  
  def initialize( theParent )
    
    #call parent constructor
    super(theParent, :opts=> LAYOUT_FILL || MATRIX_BY_ROWS);
    
  end
  
  def load_licenses( )
    
    by_check = FXCheckButton.new( self, '') ;
      by_icon = FXPNGIcon.new( app, File.open("../../../img/icons/by.png","rb").read );
    by_icon_label = FXLabel.new( self, "BY" ,  :icon => by_icon);
    
    cc_check = FXCheckButton.new( self, '') ;
      cc_icon = FXPNGIcon.new( app, File.open("../../../img/icons/cc.png","rb").read );
    cc_icon_label = FXLabel.new( self, "CC" , :icon => cc_icon);
    
    nc_check = FXCheckButton.new( self, '') ;
      nc_icon = FXPNGIcon.new( app, File.open("../../../img/icons/nc.png","rb").read );
    nc_icon_label = FXLabel.new( self, "NC" , :icon => nc_icon);
    
    nc_eu_check = FXCheckButton.new( self, '') ;
      nc_eu_icon = FXPNGIcon.new( app, File.open("../../../img/icons/nc-eu.png","rb").read );
    nc_eu_icon_label = FXLabel.new( self, "NC-EU" , :icon => nc_eu_icon);
    
    nc_jp_check = FXCheckButton.new( self, '') ;
      nc_jp_icon = FXPNGIcon.new( app, File.open("../../../img/icons/nc-jp.png","rb").read );
    nc_jp_icon_label = FXLabel.new( self, "NC-JP" , :icon => nc_jp_icon);
    
    nd_check = FXCheckButton.new( self, '') ;
      nd_icon = FXPNGIcon.new( app, File.open("../../../img/icons/nd.png","rb").read );
    nd_icon_label = FXLabel.new( self, "ND" , :icon => nd_icon);
  end
  
end
