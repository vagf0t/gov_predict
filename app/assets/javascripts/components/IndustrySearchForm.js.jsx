var IndustrySearchForm = createReactClass({
    handleSearch: function() {
        var industry_query = ReactDOM.findDOMNode(this.refs.industry_query).checked;
        var query = this.props.query;
        var name_query = this.props.name_query;
        var surname_query = this.props.surname_query;
        var account_query = this.props.account_query;
        var post_query = this.props.post_query;
        var link_query = this.props.link_query;
        var original_link_query = this.props.original_link_query;
        var from_query = this.props.from_query;
        var to_query = this.props.to_query;
        var state_governors_query = this.props.state_governors_query;
        var federal_legislators_query = this.props.federal_legislators_query;
        var federal_agency_query = this.props.federal_agency_query;

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
                    industry_query: industry_query,
                    state_governors_query: state_governors_query,
                    link_query: link_query,
                    federal_agency_query: federal_agency_query},
            success: function(posts) {
                self.props.handleSearch(
                    posts,
                    query,
                    name_query,
                    surname_query,
                    account_query,
                    post_query,
                    link_query,
                    to_query,
                    original_link_query,
                    federal_legislators_query,
                    state_governors_query,
                    industry_query,
                    from_query,
                    federal_agency_query);
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
                   ref="industry_query"
                   id="industry_query_input"/>
        )
    }
});

