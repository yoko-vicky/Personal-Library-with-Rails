const { environment } = require('@rails/webpacker');

// Add jQuery start
const webpack = require('webpack');
environment.plugins.prepend(
  'Provide',
  new webpack.ProvidePlugin({
    $: 'jquery/src/jquery',
    jQuery: 'jquery/src/jquery',
  }),
);
// Add jQuery end

module.exports = environment;
