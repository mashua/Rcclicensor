require 'fox16'
require 'rmagick'

include Fox ;

class MainWindow < FXMainWindow

  def initialize( app, title, w, h )

    super( app, title, :width => w, :height => h )
    
    #create the layout

    #this is the main frame
    @main_frame = FXVerticalFrame.new(self, :opts => LAYOUT_FILL) ;
    add_menu_bar() ;
    
    @main_window_splitter = FXSplitter.new( @main_frame, :opts=> SPLITTER_HORIZONTAL|LAYOUT_FILL);
    
    @group_dir_list = FXGroupBox.new( @main_window_splitter, "Directory Selection",
                                      GROUPBOX_TITLE_LEFT|FRAME_RIDGE|LAYOUT_FILL_X) ;
    
    dirlist = FXDirList.new( @group_dir_list, 
                             :opts => ( TREELIST_SHOWS_LINES|TREELIST_SHOWS_BOXES|FRAME_SUNKEN|FRAME_THICK|
                                        LAYOUT_FILL_X|LAYOUT_FILL_Y)) ;
    
    @group_licenses = FXGroupBox.new( @main_window_splitter, "Choose your license",
                              GROUPBOX_TITLE_CENTER|FRAME_RIDGE|LAYOUT_FILL_X) ;
                            
          
    
    #add cc-options radio buttons at the packer, and then the packer at the group
    #add a radio box with no string, add the icon, and finally add the license label png icon
    packer = FXPacker.new( @group_licenses, :opts => LAYOUT_FILL)
    hframe = FXHorizontalFrame.new( packer, :opts => LAYOUT_FILL_X)

    by_check = FXCheckButton.new( hframe, '') ;
      by_icon = FXPNGIcon.new( app, File.open("../../../img/icons/by.png","rb").read );
    by_icon_label = FXLabel.new( hframe, "BY" , :icon => by_icon);
    
    cc_check = FXCheckButton.new( hframe, '') ;
      cc_icon = FXPNGIcon.new( app, File.open("../../../img/icons/cc.png","rb").read );
    cc_icon_label = FXLabel.new( hframe, "CC" , :icon => cc_icon);
    
    nc_check = FXCheckButton.new( hframe, '') ;
      nc_icon = FXPNGIcon.new( app, File.open("../../../img/icons/nc.png","rb").read );
    nc_icon_label = FXLabel.new( hframe, "NC" , :icon => nc_icon);
    
    nc_eu_check = FXCheckButton.new( hframe, '') ;
      nc_eu_icon = FXPNGIcon.new( app, File.open("../../../img/icons/nc-eu.png","rb").read );
    nc_eu_icon_label = FXLabel.new( hframe, "NC-EU" , :icon => nc_eu_icon);
    
    nc_jp_check = FXCheckButton.new( hframe, '') ;
      nc_jp_icon = FXPNGIcon.new( app, File.open("../../../img/icons/nc-jp.png","rb").read );
    nc_jp_icon_label = FXLabel.new( hframe, "NC-JP" , :icon => nc_jp_icon);
    
    nd_check = FXCheckButton.new( hframe, '') ;
      nd_icon = FXPNGIcon.new( app, File.open("../../../img/icons/nd.png","rb").read );
    nd_icon_label = FXLabel.new( hframe, "ND" , :icon => nd_icon);
    
    
    @group2 = FXGroupBox.new( @main_frame, "image files on selected direcory",
                            GROUPBOX_TITLE_LEFT|FRAME_RIDGE|LAYOUT_FILL_X|LAYOUT_FILL_Y)
    image_list = FXList.new( @group2, :opts=>LAYOUT_FILL_X|LAYOUT_FILL_Y   ) ;                      
    
    @group3 = FXGroupBox.new( @main_frame, "Status",
                            GROUPBOX_TITLE_LEFT|FRAME_RIDGE|LAYOUT_FILL_X|LAYOUT_FILL_Y)
   
    @status_bar= FXStatusBar.new( @main_frame,
                              LAYOUT_SIDE_BOTTOM|LAYOUT_FILL_X|STATUSBAR_WITH_DRAGCORNER ) ;

    @clockLabel = FXLabel.new( @status_bar, Time.now().strftime("%I:%M:%S %p" ), nil,
                               LAYOUT_FILL_Y|LAYOUT_RIGHT|FRAME_SUNKEN ) ;

    

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

  

end #fxmainwindow ends here.

  app = FXApp.new
   test = MainWindow.new( app, "Rcclicensor welcomes you", 1000, 600)

  app.create
  app.run

