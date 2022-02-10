
import FreeMarketFramework

var marketPlace = MarketPlace.demoMarketPlace

marketPlace.current

marketPlace.scheduledEntries[0].reduce(0) {
  $0 + (($1.priceType != .normal && $1.available) ? 1 : 0)
}

marketPlace.hasExceptionalPricingCurrently

