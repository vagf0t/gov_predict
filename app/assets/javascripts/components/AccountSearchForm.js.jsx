var AccountSearchForm = createReactClass({
    handleSearch: function() {
        var account_query = ReactDOM.findDOMNode(this.refs.account_query).value;
        var query = this.props.query;
        var name_query = this.props.name_query;
        var surname_query = this.props.surname_query;
        var post_query = this.props.post_query;

        var self = this;
        $.ajax({
            url: '/api/posts/search',
            data: { query: query,
                    name_query: name_query,
                    surname_query: surname_query,
                    account_query: account_query,
                    post_query: post_query},
            success: function(posts) {
                self.props.handleSearch(posts,
                    query,
                    name_query,
                    surname_query,
                    account_query,
                    post_query);
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
                   placeholder="Filter by account type..."
                   ref="account_query"
                   id="account_query_input"/>
        )
    }
});

