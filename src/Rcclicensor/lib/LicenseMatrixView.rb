require_relative 'LicenseView'

#subclass the FXMatrix Layout!
class LicenseMatrixView < FXMatrix
  
  attr_accessor :theIconsPath
  
  def initialize( theParent, iconsPath  )
    
    @theIconsPath = iconsPath;
    #call parent constructor
    super(theParent, :opts=> LAYOUT_FILL || MATRIX_BY_COLUMNS);
    
  end
  
  def load_licenses( )
    
    #the directory to return after we finish licenses-icon polling
    oldir = Dir.pwd;    
    iconFiles = Dir.chdir( @theIconsPath ); #go to the licenses directory
    iconFiles = Dir.glob("*.{png,jpg,jpeg,tiff,ico }") ;
    
    iconFiles.each { |iconelement|  #create the icons
      LicenseView.new( self, iconelement );
    }
    
    Dir.chdir(oldir) ; # go to the previous directory, after finishing licenses processing
    
  end
  
  def layout
    self.numColumns  = 2;
    super;
  end
  
end
