module Clappr.Plugins.ClickToPause where

import Clappr (Plugin, NativeOptions)
import Data.Array ((:))

foreign import clickToPause ∷ Plugin

setup ∷ ∀ r. NativeOptions r → NativeOptions r
setup opts = opts { plugins = clickToPause : opts.plugins }
