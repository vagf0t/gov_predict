var FederalLegislatorsSearchForm = createReactClass({
    handleSearch: function() {
        var federal_legislators_query = ReactDOM.findDOMNode(this.refs.federal_legislators_query).value;
        var query = this.props.query;
        var name_query = this.props.name_query;
        var surname_query = this.props.surname_query;
        var account_query = this.props.account_query;
        var post_query = this.props.post_query;
        var link_query = this.props.link_query;
        var from_query = this.props.from_query;
        var to_query = this.props.to_query;
        var industry_query = this.props.industry_query;

        var self = this;
        $.ajax({
            url: '/api/posts/search',
            data: { query: query,
                    name_query: name_query,
                    surname_query: surname_query,
                    account_query: account_query,
                    post_query: post_query,
                    federal_legislators_query: federal_legislators_query,
                    industry_query: industry_query,
                    from_query: from_query,
                    to_query: to_query,
                    link_query: link_query},
            success: function(posts) {
                self.props.handleSearch(
                    posts,
                    query,
                    name_query,
                    surname_query,
                    account_query,
                    post_query,
                    from_query,
                    to_query,
                    link_query,
                    industry_query,
                    federal_legislators_query);
            },
            error: function(xhr, status, error) {
                alert('Search error: ', status, xhr, error);
            }
        });
    },
    render: function() {
        return(
            <input onChange={this.handleSearch}
                   type="checkbox"
                   className="form-control"
                   placeholder="Filter by list..."
                   ref="federal_legislators_query"
                   id="federal_legislators_query_input"/>
        )
    }
});

