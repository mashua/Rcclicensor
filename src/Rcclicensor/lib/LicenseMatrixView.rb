require_relative 'LicenseView'

#subclass the FXScrollWindow Layout!
class LicenseMatrixView < FXScrollWindow
  
  attr_accessor :theIconsPath
  attr_accessor :theLicensesMatrix
  attr_accessor :totalLicenses
  LICENSE_ELEMENT_WIDTH = 130;
  
  
  def initialize( theParent, iconsPath  )
    super(theParent, :opts=> LAYOUT_FILL );
    @theIconsPath = iconsPath;
    @totalLicenses = 0;
    #call parent constructor
    @theLicensesMatrix = FXMatrix.new( self, :opts => LAYOUT_FILL | MATRIX_BY_COLUMNS  )
    
  end
  
  def load_licenses( )
    
    #the directory to return after we finish licenses-icon polling
    oldir = Dir.pwd;    
    iconFiles = Dir.chdir( @theIconsPath ); #go to the licenses directory
    iconFiles = Dir.glob("*.{png,jpg,jpeg,tiff,ico }") ;
    
    iconFiles.each { |iconelement|  #create the icons
      temp = LicenseView.new( @theLicensesMatrix, iconelement );
#      @totalLicenses = @totalLicenses+1;
      @totalLicenses +=1;
      
      puts "Adding license number: #{@totalLicenses}, with:"
      puts "width #{temp.licenseViewWidth} and height #{temp.licenseViewHeight}" ;
      
    }
    
    Dir.chdir(oldir) ; # go to the previous directory, after finishing licenses processing
    
  end
  
  def layout
    
#    puts "CONTENT LAYOUT CHANGE!!!! in matrix"
#    puts "Licenses Loaded: #{@totalLicenses}"
#    puts "Current width is: #{self.width}"
#    puts "Current height is: #{self.height}"
    
    contentWindow.numColumns  =  self.width / LICENSE_ELEMENT_WIDTH;
    
    super
    
  end
  
end
