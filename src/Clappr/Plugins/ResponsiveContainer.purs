module Clappr.Plugins.ResponsiveContainer where

import Clappr (Plugin, NativeOptions)
import Data.Array ((:))

foreign import responsiveContainer ∷ Plugin

setup ∷ ∀ r. NativeOptions r → NativeOptions r
setup opts = opts { plugins = responsiveContainer : opts.plugins }
