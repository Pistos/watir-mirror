# feature tests for Images
# revision: $Revision$

$LOAD_PATH.unshift File.join(File.dirname(__FILE__), '..') if $0 == __FILE__
require 'unittests/setup'

class TC_Images < Test::Unit::TestCase
    include Watir

    def gotoImagePage()
        $ie.goto($htmlRoot + "images1.html")
    end



    def test_imageExists

        gotoImagePage()


        assert_false( $ie.image(:name , "missing_name").exists?  )
        assert(       $ie.image(:name , "circle").exists?  )
        assert(       $ie.image(:name , /circ/ ).exists?  )



        assert_false( $ie.image(:id , "missing_id").exists?  )
        assert(       $ie.image(:id , "square").exists?  )
        assert(       $ie.image(:id , /squ/ ).exists?  )


        assert_false( $ie.image(:src, "missingsrc.gif").exists?  )

# BP -- This fails for me but not for Paul. It doesn't make sense to me that it should pass.  
#        assert(       $ie.image(:src , "file:///#{$myDir}/html/images/triangle.jpg").exists?  )
        assert(       $ie.image(:src , /triangle/ ).exists?  )

        assert(       $ie.image(:alt , "circle" ).exists?  )
        assert(       $ie.image(:alt , /cir/ ).exists?  )

        assert_false(  $ie.image(:alt , "triangle" ).exists?  )
        assert_false(  $ie.image(:alt , /tri/ ).exists?  )



    end


    def test_image_click
        gotoImagePage()
        assert_raises(UnknownObjectException ) { $ie.image(:name, "no_image_with_this").click }
        assert_raises(UnknownObjectException ) { $ie.image(:id, "no_image_with_this").click }
        assert_raises(UnknownObjectException ) { $ie.image(:src, "no_image_with_this").click}
        assert_raises(UnknownObjectException ) { $ie.image(:alt, "no_image_with_this").click}


        $ie.image(:src, /button/).click

        assert($ie.pageContainsText("PASS") )


    end

    def test_imageHasLoaded
        gotoImagePage()
        assert_raises(UnknownObjectException ) { $ie.image(:name, "no_image_with_this").hasLoaded? }
        assert_raises(UnknownObjectException ) { $ie.image(:id, "no_image_with_this").hasLoaded? }
        assert_raises(UnknownObjectException ) { $ie.image(:src, "no_image_with_this").hasLoaded? }
        assert_raises(UnknownObjectException ) { $ie.image(:alt, "no_image_with_this").hasLoaded? }


        assert_false( $ie.image(:name, "themissingimage").hasLoaded?  )
        assert( $ie.image(:name, "circle").hasLoaded?  )

        assert( $ie.image(:alt, "circle").hasLoaded?  )
        assert( $ie.image(:alt, /cir/ ).hasLoaded?  )


    end

    def test_to_s

        gotoImagePage()
        assert_raises(UnknownObjectException ) { $ie.image(:name, "no_image_with_this").hasLoaded? }
        assert_raises(UnknownObjectException ) { $ie.image(:id, "no_image_with_this").hasLoaded? }
        assert_raises(UnknownObjectException ) { $ie.image(:src, "no_image_with_this").hasLoaded? }

        puts"--------------------- To String tests -------------------"

        puts $ie.image(:name , "circle").to_s

    end

end

