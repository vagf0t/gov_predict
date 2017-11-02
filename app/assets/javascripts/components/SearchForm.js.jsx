var SearchForm = createReactClass({
    handleSearch: function() {
        var query = ReactDOM.findDOMNode(this.refs.query).value;
        var name_query = this.props.name_query;
        var surname_query = this.props.surname_query;
        var account_query = this.props.account_query;
        var post_query = this.props.post_query;
        var link_query = this.props.link_query;
        var original_link_query = this.props.original_link_query;

        var self = this;
        $.ajax({
            url: '/api/posts/search',
            data: {
                query: query,
                name_query: name_query,
                surname_query: surname_query,
                account_query: account_query,
                post_query: post_query,
                link_query: link_query,
                original_link_query: original_link_query},
            success: function(posts) {
                self.props.handleSearch(
                    posts,
                    query,
                    name_query,
                    surname_query,
                    account_query,
                    post_query,
                    link_query,
                    original_link_query);
            },
            error: function(xhr, status, error) {
                alert('Search error: ', status, xhr, error);
            }
        });
    },
    render: function() {
        return(
            <input onChange={this.handleSearch}
                   type="text"
                   className="form-control"
                   placeholder="Type search phrase here..."
                   ref="query" />
        )
    }
});

