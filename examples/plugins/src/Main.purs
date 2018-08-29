module Examples.Plugins.Main where

import Prelude

import Clappr (Options, Parent(..), clappr, flasHls, toNativeOptions)
import Clappr.Plugins.ClickToPause as ClickToPause
import Clappr.Plugins.DvrControls as DvrControls
import Clappr.Plugins.Favicon as Favicon
import Clappr.Plugins.FlasHls (flashVersion)
import Clappr.Plugins.FlasHls (setup) as FlasHljs
import Clappr.Plugins.FlasHls as FlasHls
import Clappr.Plugins.PlayerSize (pct, px)
import Clappr.Plugins.PlayerSize (setup) as PlayerSize
import Clappr.Plugins.Poster as Poster
import Clappr.Plugins.ResponsiveContainer (responsiveContainer)
import Clappr.Plugins.ResponsiveContainer as ResponsiveContainer
import Clappr.Plugins.Streamroot as Streamroot
import Clappr.Plugins.Watermark as Watermark
import Control.Monad.Aff (launchAff)
import Control.Monad.Aff.Console (log)
import Control.Monad.Eff.Class (liftEff)
import Data.Maybe (Maybe(..))
import Data.Nullable (toMaybe)
import Debug.Trace (traceAnyA)

opts parentId source =
  { autoPlay: false
  , baseUrl: Nothing
  , hlsjsConfig: Nothing
  , mute: false
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

main {parentId, source, streamrootKey} = launchAff $ do
  fv ← liftEff flashVersion
  flash ← liftEff flasHls
  traceAnyA fv
  let
    baseUrl = "/node_modules/clappr/dist"
    o = FlasHls.setup fv flash baseUrl
      <<< Favicon.setup
      <<< ClickToPause.setup
      <<< Watermark.setup watermark
      <<< Poster.setup ({ poster: Poster.Url posterUrl, showOnVideoEnd: false, showForNoOp: false })
      <<< DvrControls.setup
      <<< ResponsiveContainer.setup { height: 2.0, width: 20.0 }
      -- <<< PlayerSize.setup { height: px 320.0, width: pct 50.0 }
      <<< toNativeOptions
      $ (opts parentId source)
  case (toMaybe streamrootKey) of
    Just key → do
      o' ← Streamroot.setup key Streamroot.defaultDnaConfig o
      liftEff $ clappr o'
    Nothing → liftEff $ clappr o

