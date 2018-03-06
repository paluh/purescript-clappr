module Examples.Plugins.Main where

import Prelude

import Clappr (Options, Parent(..), clappr, toNativeOptions)
import Clappr.Plugins.ClickToPause as ClickToPause
import Clappr.Plugins.Favicon as Favicon
import Clappr.Plugins.Poster as Poster
import Clappr.Plugins.Watermark as Watermark
import Clappr.Plugins.ResponsiveContainer as ResponsiveContainer
import Clappr.Plugins.DvrControls as DvrControls
import Clappr.Plugins.Streamroot as Streamroot
import Data.Maybe (Maybe(..))

opts parentId source =
  { baseUrl: Nothing
  , parent: ParentId parentId
  , source: source
  }

posterUrl = "https://raw.githubusercontent.com/clappr/clappr/master/images/stats.jpg"
logoUrl = "https://cloud.githubusercontent.com/assets/244265/6373134/a845eb50-bce7-11e4-80f2-592ba29972ab.png"

watermark ∷ Watermark.Options
watermark =
  { link: Just "https://github.com/clappr/clappr"
  , position: Watermark.TopRight
  , url: logoUrl
  }


p2p =
  { mobileBrowserEnable: true
  , streamrootKey: "YOUR KEY HERE"
  , debug: true
  }

run parentId source
  = clappr
  <<< Streamroot.setupPlayback (Just p2p)
  <<< Favicon.setup
  <<< ClickToPause.setup
  <<< ResponsiveContainer.setup
  <<< Watermark.setup watermark
  <<< Poster.setup ({ poster: Poster.Url posterUrl, showOnVideoEnd: false, showForNoOp: false })
  <<< DvrControls.setup
  <<< toNativeOptions
  $ (opts parentId source)

