Deface::Override.new(virtual_path:  "spree/shared/_products",
                     insert_after:  "[data-hook='products_search_results_heading_no_results_found']",
                     text:          "<p><%= I18n.t(:no_products_found) %></p>",
                     name:          "add_sample_data_notice")


