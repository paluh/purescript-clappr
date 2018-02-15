module Examples.Plugins.Main where

import Prelude

import Clappr (Options, Parent(..), clappr', toNativeOptions)
import Clappr.Plugins.ClickToPause as ClickToPause
import Clappr.Plugins.Favicon as Favicon
import Clappr.Plugins.Poster as Poster
import Clappr.Plugins.Watermark as Watermark
import Clappr.Plugins.ResponsiveContainer as ResponsiveContainer
import Data.Maybe (Maybe(..))

opts parentId source =
  { source: source
  , parent: ParentId parentId
  }

posterUrl = "https://raw.githubusercontent.com/clappr/clappr/master/images/stats.jpg"
logoUrl = "https://cloud.githubusercontent.com/assets/244265/6373134/a845eb50-bce7-11e4-80f2-592ba29972ab.png"

watermark ∷ Watermark.Options
watermark =
  { link: Just "https://github.com/clappr/clappr"
  , position: Watermark.TopRight
  , url: logoUrl
  }

run parentId source
  = clappr'
  <<< Favicon.setup
  <<< ClickToPause.setup
  <<< ResponsiveContainer.setup
  <<< Watermark.setup watermark
  <<< Poster.setup ({ poster: Poster.Url posterUrl, showOnVideoEnd: false, showForNoOp: false })
  <<< toNativeOptions
  $ (opts parentId source)

