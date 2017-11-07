var LinkSearchForm = createReactClass({
    handleSearch: function() {
        var link_query = ReactDOM.findDOMNode(this.refs.link_query).value;
        var query = this.props.query;
        var name_query = this.props.name_query;
        var account_query = this.props.account_query;
        var post_query = this.props.post_query;
        var surname_query = this.props.surname_query;
        var original_link_query = this.props.original_link_query;
        var from_query = this.props.from_query;

        var self = this;
        $.ajax({
            url: '/api/posts/search',
            data: { query: query,
                    name_query: name_query,
                    surname_query: surname_query,
                    account_query: account_query,
                    post_query: post_query,
                    link_query: link_query,
                    from_query: from_query,
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
                    from_query,
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
                   placeholder="Filter by link..."
                   ref="link_query"
                   id="link_query_input"/>
        )
    }
});

