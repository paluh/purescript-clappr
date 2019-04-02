module Examples.Plugins.Main where

import Prelude

import Clappr (Clappr, Options) as Clappr
import Clappr (Parent(..), clappr, flasHls, toNativeOptions)
import Clappr.Plugins.ClickToPause as ClickToPause
import Clappr.Plugins.Favicon (setup) as Favicon
import Clappr.Plugins.FlasHls (flashVersion)
import Clappr.Plugins.FlasHls (setup) as FlasHls
import Clappr.Plugins.Poster (Poster(..), setup) as Poster
import Clappr.Plugins.ReplayOnBuffering (Timeout(..), setup) as ReplayOnBuffering
import Clappr.Plugins.ResponsiveContainer as ResponsiveContainer
import Clappr.Plugins.Thumbnails (setup) as Thumbnails
import Clappr.Plugins.Watermark as Watermark
import Data.Maybe (Maybe(..))
import Effect (Effect)

opts ∷ String → String → Clappr.Options
opts parentId source =
  { autoPlay: true
  , baseUrl: Nothing
  , hlsjsConfig: Nothing
  , hlsRecoverAttempts: Just 1
  , mute: true
  , parent: ParentId parentId
  , source: source
  }

posterUrl ∷ String
posterUrl = "https://raw.githubusercontent.com/clappr/clappr/master/images/stats.jpg"

logoUrl ∷ String
logoUrl =
  "https://cloud.githubusercontent.com/assets/244265/6373134/a845eb50-bce7-11e4-80f2-592ba29972ab.png"

watermark ∷ Watermark.Options
watermark =
  { link: Just "https://github.com/clappr/clappr"
  , position: Watermark.TopRight
  , url: logoUrl
  }

main ∷
  { source ∷ String
  , parentId ∷ String
  }
  → Effect Clappr.Clappr
main { parentId, source } = do
  fv ← flashVersion
  flash ← flasHls
  let
    baseUrl = "/node_modules/clappr/dist"
    o
      = FlasHls.setup fv flash baseUrl
      <<< Poster.setup (Just { poster: Poster.Url posterUrl, showOnVideoEnd: false, showForNoOp: false })
      <<< Thumbnails.setup
        { backdropHeight: Just 80
        , spotlightHeight: Just 80
        , thumbs:
            [ { time: 0, url: "https://i.cloudup.com/GSbXxvCsBK.png"}
            , { time: 60, url: "https://i.cloudup.com/GSbXxvCsBK.png"}
            , { time: 120, url: "https://i.cloudup.com/GSbXxvCsBK.png"}
            ]
        }
      <<< ReplayOnBuffering.setup (ReplayOnBuffering.Timeout 10)
      -- | If you want to test PlayerSize plugin please disable ResponsiveContainer
      -- <<< PlayerSize.setup { height: px 620.0, width: pct 80.0 }
      <<< ResponsiveContainer.setup { height: 9.0, width: 16.0 }
      <<< Watermark.setup watermark
      <<< Favicon.setup
      <<< ClickToPause.setup
      <<< toNativeOptions
      $ (opts parentId source)
    -- | Not migrated yet
    -- <<< DvrControls.setup
    -- <<< Log.setup

  clappr o

