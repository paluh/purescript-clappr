module Examples.Plugins.Main where

import Prelude

import Clappr (Options, Parent(..), clappr, flasHls, toNativeOptions)
import Clappr.Events (onContainerBitrate, onContainerError, onPlaybackError, onPlayerError, onPlayerFullscreen, onPlayerPause, onPlayerPlay, onPlayerReady, onPlayerResize, onPlayerTimeupdate, onPlayerVolumeupdate)
import Clappr.Plugins.ClickToPause as ClickToPause
import Clappr.Plugins.DvrControls as DvrControls
import Clappr.Plugins.Favicon as Favicon
import Clappr.Plugins.FlasHls (flashVersion)
import Clappr.Plugins.FlasHls (setup) as FlasHljs
import Clappr.Plugins.FlasHls as FlasHls
import Clappr.Plugins.PlayerSize (pct, px)
import Clappr.Plugins.PlayerSize (setup) as PlayerSize
import Clappr.Plugins.Poster as Poster
import Clappr.Plugins.ReplayOnBuffering (Timeout(..), setup) as ReplayOnBuffering
import Clappr.Plugins.ResponsiveContainer (responsiveContainer)
import Clappr.Plugins.ResponsiveContainer as ResponsiveContainer
import Clappr.Plugins.Streamroot as Streamroot
import Clappr.Plugins.Thumbnails (setup) as Thumbnails
import Clappr.Plugins.Watermark as Watermark
import Control.Monad.Aff (launchAff)
import Control.Monad.Aff.Console (log)
import Control.Monad.Eff.Class (liftEff)
import Control.Monad.Eff.Console (log) as E
import Control.Monad.Eff.Ref (newRef, readRef, writeRef)
import DOM.HTML.History (back)
import Data.Maybe (Maybe(..))
import Data.Nullable (toMaybe)
import Debug.Trace (traceAnyA)

opts parentId source =
  { autoPlay: true
  , baseUrl: Nothing
  , hlsjsConfig: Nothing
  , hlsRecoverAttempts: Just 1
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
      <<< DvrControls.setup
      -- <<< Log.setup
      <<< ReplayOnBuffering.setup (ReplayOnBuffering.Timeout 10)
      <<< ResponsiveContainer.setup { height: 2.0, width: 20.0 }
      -- <<< PlayerSize.setup { height: px 320.0, width: pct 50.0 }
      <<< toNativeOptions
      $ (opts parentId source)

  c ← case (toMaybe streamrootKey) of
    Just key → do
      o' ← Streamroot.setup key Streamroot.defaultDnaConfig o
      liftEff $ clappr o'
    Nothing →
      liftEff $ clappr o
  liftEff $ do
    onContainerBitrate c (\b → do
      E.log "CONTAINER_BITRATE"
      traceAnyA b)
    onContainerError c (\e → do
      E.log "CONTAINER_ERROR"
      traceAnyA e)
    onPlaybackError c (\e → do
      E.log "PLAYBACK_ERROR"
      traceAnyA e)
    onPlayerError c (\e → do
      E.log "PLAYER_ERROR"
      E.log "Have you changed fake hls url in index.html?"
      traceAnyA e)
    onPlayerFullscreen c (\b → do
      E.log "PLAYER_FULLSCREEN"
      traceAnyA b)
    onPlayerPause c (E.log "PLAYER_PAUSE")
    onPlayerPlay c (E.log "PLAYER_PLAY")
    onPlayerReady c (E.log "PLAYER_READY")
    onPlayerResize c (\s → do
      E.log "PLAYER_RESIZE"
      traceAnyA s)
    -- throttling timeupdate a bit
    ir ← newRef 0
    onPlayerTimeupdate c (\p → do
      i ← readRef ir
      when (i `mod` 50 == 0) do
        E.log "PLAYER_TIMEUPDATE (throttled)"
        traceAnyA p
      writeRef ir (i + 1))
    onPlayerVolumeupdate c (\v → do
      E.log "PLAYER_VOLUMEUPDATE"
      traceAnyA v)
  -- liftEff $ Clappr.Log.setLevel Clappr.Log.debug

