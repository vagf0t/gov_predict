var OriginalLinkSearchForm = createReactClass({
    handleSearch: function() {
        var original_link_query = ReactDOM.findDOMNode(this.refs.original_link_query).value;
        var query = this.props.query;
        var name_query = this.props.name_query;
        var account_query = this.props.account_query;
        var post_query = this.props.post_query;
        var surname_query = this.props.surname_query;
        var link_query = this.props.link_query;
        var from_query = this.props.from_query;
        var to_query = this.props.to_query;
        var federal_legislators_query = this.props.federal_legislators_query;
        var industry_query = this.props.industry_query;

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
                    to_query: to_query,
                    industry_query: industry_query,
                    federal_legislators_query: federal_legislators_query,
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
                    to_query,
                    industry_query,
                    federal_legislators_query,
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
                   placeholder="Filter by original link..."
                   ref="original_link_query"
                   id="original_link_query_input"/>
        )
    }
});

