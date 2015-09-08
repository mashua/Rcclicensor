require 'fox16'
require 'rmagick'

include Fox ;

require_relative 'LicenseMatrixView'

class MainWindow < FXMainWindow

  def initialize( app, title, w, h )

    super( app, title, :width => w, :height => h )
    
    #create the layout

    #this is the main frame
    @main_frame = FXVerticalFrame.new(self, :opts => LAYOUT_FILL) ;
    add_menu_bar() ;
    
    @main_window_splitter = FXSplitter.new( @main_frame, :opts=>SPLITTER_VERTICAL|LAYOUT_FILL);
    
    @directory_licenses_splitter = FXSplitter.new( @main_window_splitter, :opts=> SPLITTER_HORIZONTAL|LAYOUT_FILL);
    
    @group_dir_list = FXGroupBox.new( @directory_licenses_splitter, "Directory Selection",
                                      GROUPBOX_TITLE_LEFT|FRAME_RIDGE|LAYOUT_FILL_X) ;
    
    dirlist = FXDirList.new( @group_dir_list, 
                             :opts => ( DIRLIST_NO_OWN_ASSOC|DIRLIST_SHOWFILES|TREELIST_SHOWS_LINES|TREELIST_SHOWS_BOXES|FRAME_SUNKEN|FRAME_THICK|
                                        LAYOUT_FILL_X|LAYOUT_FILL_Y) ) ;
                                    
    dirlist.setDirectory("/home/mashua/Pictures",false);
    puts dirlist.pattern = "*.jpg"
    
    #Called whenever the selection is changed
    dirlist.connect(SEL_CHANGED) { 
      
      puts "Selected Item is: #{dirlist.currentFile }"
      
    }
    
    @group_licenses = FXGroupBox.new( @directory_licenses_splitter, "Choose your license",
                                      GROUPBOX_TITLE_CENTER|FRAME_RIDGE|LAYOUT_FILL_X) ;
                            
    
    #add cc-options radio buttons at the packer, and then the packer at the group
    #add a radio box with no string, add the icon, and finally add the license label png icon
    #packer = FXPacker.new( @group_licenses, :opts => LAYOUT_FILL)
    licenses_matrix = LicenseMatrixView.new( @group_licenses, "../../../img/icons/" );
    licenses_matrix.load_licenses();
    
    @group2 = FXGroupBox.new( @main_window_splitter, "image files on selected direcory",
                            GROUPBOX_TITLE_LEFT|FRAME_RIDGE|LAYOUT_FILL_X|LAYOUT_FILL_Y)
    image_list = FXList.new( @group2, :opts=>LAYOUT_FILL_X|LAYOUT_FILL_Y   ) ;                      
    
    @group3 = FXGroupBox.new( @main_frame, "Status",
                            GROUPBOX_TITLE_LEFT|FRAME_RIDGE|LAYOUT_FILL_X|LAYOUT_FILL_Y)
   
    @status_bar= FXStatusBar.new( @main_frame,
                              LAYOUT_SIDE_BOTTOM|LAYOUT_FILL_X|STATUSBAR_WITH_DRAGCORNER ) ;

    @clockLabel = FXLabel.new( @status_bar, Time.now().strftime("%I:%M:%S %p" ), nil,
                               LAYOUT_FILL_Y|LAYOUT_RIGHT|FRAME_SUNKEN ) ;
    
    @main_window_splitter.setSplit(0, self.height / 2) ;
    @main_window_splitter.setSplit(1, (self.height / 2) + 100 ) ;
    
#    @main_window_splitter.connect(SEL_CHANGED) { |sender, sel, ptr|
#      
##      layout();
##      puts "Ouch!"
#      @main_window_splitter.setSplit(0, self.height / 2) ;
#      @main_window_splitter.setSplit(1, self.height / 2) ;
#    
#    }

  end

  def create
    super
    show( PLACEMENT_SCREEN)
  end

  private
  def add_menu_bar

    menu_bar = FXMenuBar.new( @main_frame, LAYOUT_SIDE_TOP | LAYOUT_FILL_X );

    file_menu = FXMenuPane.new( self);

    FXMenuTitle.new( menu_bar, "File", :popupMenu => file_menu );

    new_cmd = FXMenuCommand.new( file_menu, "(empty for now...)" );

    options_menu = FXMenuPane.new ( self) ;
    FXMenuTitle.new( menu_bar,"Options", :popupMenu=> options_menu) ;
    option_sub_menu = FXMenuTitle.new( options_menu,"(nothing for now)",nil ) ;
    
    about_menu = FXMenuPane.new(self) ;
    FXMenuTitle.new( menu_bar,"About", :popupMenu => about_menu ) ;
    info = FXMenuCommand.new( about_menu, "What's the fuzz about...") ;

    FXMenuSeparator.new( file_menu) ;
    exit_cmd = FXMenuCommand.new( file_menu, "Exit") ;
    exit_cmd.connect(SEL_COMMAND) do
      exit
    end

  end

#  def layout
#    
#    puts "CONTENT LAYOUT CHANGE in main form!!!!"
#    puts "Current width is: #{self.width}"
#    puts "Current height is: #{self.height}"
#    if @main_window_splitter.getSplit(0).to_i == (self.height/2).to_i && 
#       @main_window_splitter.getSplit(1).to_i == (self.height/2).to_i
#      return;
#    
#    else
#      @main_window_splitter.setSplit(0, self.height / 2) ;
#      @main_window_splitter.setSplit(1, self.height / 2) ;
#    end
#    
#    puts @main_window_splitter.getSplit(0);
#    puts @main_window_splitter.getSplit(1);
#    super
#    
#  end

end #fxmainwindow ends here.

  app = FXApp.new
   test = MainWindow.new( app, "Rcclicensor welcomes you", 1000, 600)

  app.create
  app.run

