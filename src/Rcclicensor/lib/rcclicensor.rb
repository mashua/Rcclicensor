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
    @group1 = FXGroupBox.new( @main_frame, "Choose your license",
                              GROUPBOX_TITLE_LEFT|FRAME_RIDGE|LAYOUT_FILL_X) ;
                            
    #add cc-options radio buttons at the packer, and then the packer at the group
    #add a radio box with no string, add the icon, and finally add the license label png icon
    packer = FXPacker.new( @group1, :opts => LAYOUT_FILL)
    hframe = FXHorizontalFrame.new( packer, :opts => LAYOUT_FILL_X)
    
    by_radio = FXRadioButton.new( hframe, '') ;
      by_icon = FXPNGIcon.new( app, File.open("../../../img/icons/by.png","rb").read );
    by_icon_label = FXLabel.new( hframe, "BY" , :icon => by_icon);
    
    cc_radio = FXRadioButton.new( hframe, '') ;
      cc_icon = FXPNGIcon.new( app, File.open("../../../img/icons/cc.png","rb").read );
    cc_icon_label = FXLabel.new( hframe, "CC" , :icon => cc_icon);
    
    nc_radio = FXRadioButton.new( hframe, '') ;
      nc_icon = FXPNGIcon.new( app, File.open("../../../img/icons/nc.png","rb").read );
    nc_icon_label = FXLabel.new( hframe, "NC" , :icon => nc_icon);
    
    nc_eu_radio = FXRadioButton.new( hframe, '') ;
      nc_eu_icon = FXPNGIcon.new( app, File.open("../../../img/icons/nc-eu.png","rb").read );
    nc_eu_icon_label = FXLabel.new( hframe, "NC-EU" , :icon => nc_eu_icon);
    
    nc_jp_radio = FXRadioButton.new( hframe, '') ;
      nc_jp_icon = FXPNGIcon.new( app, File.open("../../../img/icons/nc-jp.png","rb").read );
    nc_jp_icon_label = FXLabel.new( hframe, "NC-JP" , :icon => nc_jp_icon);
    
    nd_radio = FXRadioButton.new( hframe, '') ;
      nd_icon = FXPNGIcon.new( app, File.open("../../../img/icons/nd.png","rb").read );
    nd_icon_label = FXLabel.new( hframe, "ND" , :icon => nd_icon);
    
    
    @group2 = FXGroupBox.new( @main_frame, "(space)",
                            GROUPBOX_TITLE_LEFT|FRAME_RIDGE|LAYOUT_FILL_X|LAYOUT_FILL_Y)
    @group3 = FXGroupBox.new( @main_frame, "Status",
                            GROUPBOX_TITLE_LEFT|FRAME_RIDGE|LAYOUT_FILL_X|LAYOUT_FILL_Y)
    
    

    add_table() ;

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

    new_cmd = FXMenuCommand.new( file_menu, "Start Capture With FFI::PCap..." );

    new_cmd.connect( SEL_COMMAND) do
      #handler for net capture
      theCapture = FFI::PCap::Live.new( :dev=> FFI::PCap.device_names[ @intrflistbox.currentItem ] );
      theCapture.stats
      theCapture.stats.ps_recv
      theCapture.datalink.describe
      packets=[]

      theCaptureThread = Thread.new do
          theCapture.loop( :count =>50 ) do | this,pkt |   # :count => -1 for infinite loop, break with .breakloop method
          # packets << pkt
          puts "#{pkt.time} :: #{pkt.len}"
          pkt.body.each_byte {|x| print "%0.2x " % x }
          putc "\n"
          sleep(1);
        end
      end

    end

    #temporalilly disable it because its causing hang-outs on the GUI.
    new_cmd.enabled = false;

    new_cmd_2 = FXMenuCommand.new(file_menu, "Start Capture With PCaprub...");

    new_cmd_2.connect( SEL_COMMAND) do

      Thread.new do
      mypcap = ::Pcap.new

      dev = PCAPRUB::Pcap.lookupdev

      packetsize = 65535 ;

      promiscous_mode = true ;
      timeout = 0 ;

      # system("ifconfig", dev, "up")

      capture = ::Pcap.open_live( dev, packetsize, promiscous_mode, timeout ) ;

      capture_packets = 10

      begin
        capture.each do |packet|
          print packet ;

          # @table.appendRows( 34 );
          # @table.insertRows( "rr", 1, false );

        end

# ^C to stop sniffing
      rescue Interrupt
        puts "\nPacket Capture stopped by interrupt signal."

      rescue Exception => e
        puts "\nERROR: #{e}"
        retry
      end #loop ends here

      if capture.datalink == PCAPRUB::Pcap::DLT_EN10MB
        puts "Ethernet 10MB Link detected"
      end

        end #Thread code ends here

    end #command code ends here

    options_menu = FXMenuPane.new ( self) ;
    FXMenuTitle.new( menu_bar,"Options", :popupMenu=> options_menu) ;
    dissector_sub_menu = FXMenuTitle.new( options_menu,"Enable Disector",nil ) ;
    #future code for dynamic generation of disectors menu.

    about_menu = FXMenuPane.new(self) ;
    FXMenuTitle.new( menu_bar,"About", :popupMenu => about_menu ) ;
    ver_wpcap = FXMenuCommand.new( about_menu, "Wpcap Version") ;
    ver_wpcap.connect(SEL_COMMAND) do
      puts FFI::Pcap.lib_version ;
      puts FFI::Pcap.lib_version_number ;
    end

    FXMenuSeparator.new( file_menu) ;
    exit_cmd = FXMenuCommand.new( file_menu, "Exit") ;
    exit_cmd.connect(SEL_COMMAND) do
      exit
    end

  end

  def add_table

    @table = FXTable.new( @group2, :opts=> LAYOUT_FILL ) ;
    # @table.horizontalGridShown = false;
    # @table.verticalGridShown = false;
    @table.tableStyle |= TABLE_COL_SIZABLE
    # @table.editable = false;
    @table.setTableSize( 1,1, false) ;
    @table.setColumnText(0, "col1") ;
    @table.setRowText( 0, "row1") ;
    @table.rowHeaderMode = LAYOUT_FIX_WIDTH ;
    @table.rowHeaderWidth = 0;
    # @table.columnHeaderHeight = 15;

    @table.setItemText( 0, 0, "test item") ;
    # @table.setItemText( 2, 1, "This is a spanning Item") ;
    # @table.setItemJustify( 2, 1, FXTableItem::CENTER_X) ;
    # spanning_item = @table.getItem( 2, 1) ;
    # @table.setItem( 2, 2, spanning_item ) ;
    # @table.setItem( 2, 3, spanning_item ) ;
    # @table.setItem( 3, 1, spanning_item ) ;
    # @table.setItem( 3, 2, spanning_item ) ;
    # @table.setItem( 3, 3, spanning_item ) ;

  end

end #fxmainwindow ends here.

  app = FXApp.new
   test = MainWindow.new( app, "Rcclicensor welcomes you", 800, 300)

  app.create
  app.run

