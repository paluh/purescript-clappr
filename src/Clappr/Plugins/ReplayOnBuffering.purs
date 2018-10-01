module Clappr.Plugins.ReplayOnBuffering where

import Prelude

import Clappr (NativeOptionsRow, Plugin, NativeOptions) as Clappr
import Data.Array ((:))
import Data.Record (insert)
import Type.Prelude (class RowLacks, SProxy(..))

foreign import replayOnBuffering ∷ Clappr.Plugin

newtype Timeout = Timeout Int

type NativeOptionsRow r = (replayBufferingTimeout ∷ Int | r)

setup
  ∷ ∀ r
  . RowLacks "replayBufferingTimeout" (Clappr.NativeOptionsRow r)
  ⇒ Timeout
  → Clappr.NativeOptions r
  → Clappr.NativeOptions (NativeOptionsRow r)
setup (Timeout timeout) opts
  = insert (SProxy ∷ SProxy "replayBufferingTimeout") timeout
  <<< _{ plugins = replayOnBuffering : opts.plugins }
  $ opts
