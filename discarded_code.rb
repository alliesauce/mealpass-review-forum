discarded_code.rb


#in new.html.erb - restaurants
<div class="search">
      <h3>First, please check to see if the restaurant exists:</h3>

      <%= form_tag(restaurants_path, :method => "get", id: "search-form" ) do %>
        <%= text_field_tag(:search, params[:search], placeholder: "Search Restaurants") %>
        <%= submit_tag("Search") %>
      <% end %>

      <% if @restaurants.present? %>
        <%= render  %>
      <% else %>
        <p>There are is no restaurant called <%= params[:search] %>. Please continue adding it below.</p>
      <% end %>
    </div>
