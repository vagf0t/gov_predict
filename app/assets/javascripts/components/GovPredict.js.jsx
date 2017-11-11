
var GovPredict = createReactClass({
    getInitialState: function() {
        return { posts: [],
            query: null,
            name_query: null,
            surname_query: null,
            account_query: null,
            post_query: null,
            link_query: null,
            to_query: null,
            original_link_query: null,
            federal_legislators_query: false,
            industry_query: false,
            state_governors_query: false,
            from_query: null,
            federal_agency_query: false};
    },
    componentDidMount: function() {
        this.getDataFromApi();
    },
    getDataFromApi: function() {
        var self = this;
        $.ajax({
            url: '/api/posts',
            success: function(data) {
                self.setState({ posts: data });
            },
            error: function(xhr, status, error) {
                alert('Cannot get data from API: ', error);
            }
        });
    },
    handleSearch: function(posts,
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
                           federal_agency_query) {
        this.setState((prevState) => {
            return {
                posts: prevState.posts !== posts ? posts : prevState.posts,
                query: prevState.query !== query ? query : prevState.query,
                name_query: prevState.name_query !== name_query ? name_query : prevState.name_query,
                surname_query: prevState.surname_query !== surname_query ? surname_query : prevState.surname_query,
                account_query: prevState.account_query !== account_query ? account_query : prevState.account_query,
                post_query: prevState.post_query !== post_query ? post_query : prevState.post_query,
                link_query: prevState.link_query !== link_query ? link_query : prevState.link_query,
                from_query: prevState.from_query !== from_query ? from_query : prevState.from_query,
                to_query: prevState.to_query !== to_query ? to_query : prevState.to_query,
                state_governors_query: prevState.state_governors_query !== state_governors_query ? state_governors_query : prevState.state_governors_query,
                federal_legislators_query: prevState.federal_legislators_query !== federal_legislators_query ? federal_legislators_query : prevState.federal_legislators_query,
                industry_query: prevState.industry_query !== industry_query ? industry_query : prevState.industry_query,
                original_link_query: prevState.original_link_query !== original_link_query ? original_link_query : prevState.original_link_query,
                federal_agency_query: prevState.federal_agency_query !== federal_agency_query ? federal_agency_query : prevState.federal_agency_query
            }
        });
    },
    render: function() {
        return(
            <div className="container">
                <div className="jumbotron">
                    <h1>RoR-React sample</h1>
                    <p>by Evangelos Fotis</p>
                </div>
                <div className="row">
                    <div className="col-md-4">
                        <SearchForm
                            handleSearch={this.handleSearch}
                            name_query={this.state.name_query}
                            surname_query={this.state.surname_query}
                            account_query={this.state.account_query}
                            post_query={this.state.post_query}
                            link_query={this.state.link_query}
                            from_query={this.state.from_query}
                            to_query={this.state.to_query}
                            state_governors_query={this.state.state_governors_query}
                            industry_query={this.state.industry_query}
                            federal_legislators_query={this.state.federal_legislators_query}
                            original_link_query={this.state.original_link_query}
                            federal_agency_query={this.state.federal_agency_query}
                        />
                    </div>
                    <div className="col-md-2">
                        <div className="col-md-6"><b>Federal Legislators</b></div>
                        <div className="col-md-6">
                            <FederalLegislatorsSearchForm
                            handleSearch={this.handleSearch}
                            posts={this.state.posts}
                            name_query={this.state.name_query}
                            surname_query={this.state.surname_query}
                            account_query={this.state.account_query}
                            post_query={this.state.post_query}
                            link_query={this.state.link_query}
                            from_query={this.state.from_query}
                            to_query={this.state.to_query}
                            query={this.state.query}
                            state_governors_query={this.state.state_governors_query}
                            industry_query={this.state.industry_query}
                            original_link_query={this.state.original_link_query}
                            federal_agency_query={this.state.federal_agency_query}
                            />
                        </div>
                    </div>
                    <div className="col-md-2">
                        <div className="col-md-6"><b>Industry</b></div>
                        <div className="col-md-6">
                            <IndustrySearchForm
                                handleSearch={this.handleSearch}
                                posts={this.state.posts}
                                name_query={this.state.name_query}
                                surname_query={this.state.surname_query}
                                account_query={this.state.account_query}
                                post_query={this.state.post_query}
                                link_query={this.state.link_query}
                                from_query={this.state.from_query}
                                to_query={this.state.to_query}
                                query={this.state.query}
                                state_governors_query={this.state.state_governors_query}
                                federal_legislators_query={this.state.federal_legislators_query}
                                original_link_query={this.state.original_link_query}
                                federal_agency_query={this.state.federal_agency_query}
                            />
                        </div>
                    </div>
                    <div className="col-md-2">
                        <div className="col-md-6"><b>State Governors</b></div>
                        <div className="col-md-6">
                            <StateGovernorsSearchForm
                                handleSearch={this.handleSearch}
                                posts={this.state.posts}
                                name_query={this.state.name_query}
                                surname_query={this.state.surname_query}
                                account_query={this.state.account_query}
                                post_query={this.state.post_query}
                                link_query={this.state.link_query}
                                from_query={this.state.from_query}
                                to_query={this.state.to_query}
                                query={this.state.query}
                                industry_query={this.state.industry_query}
                                federal_legislators_query={this.state.federal_legislators_query}
                                original_link_query={this.state.original_link_query}
                                federal_agency_query={this.state.federal_agency_query}
                            />
                        </div>
                    </div>
                    <div className="col-md-2">
                        <div className="col-md-6"><b>Federal Agency</b></div>
                        <div className="col-md-6">
                            <FederalAgencySearchForm
                                handleSearch={this.handleSearch}
                                posts={this.state.posts}
                                name_query={this.state.name_query}
                                surname_query={this.state.surname_query}
                                account_query={this.state.account_query}
                                post_query={this.state.post_query}
                                link_query={this.state.link_query}
                                from_query={this.state.from_query}
                                to_query={this.state.to_query}
                                query={this.state.query}
                                industry_query={this.state.industry_query}
                                federal_legislators_query={this.state.federal_legislators_query}
                                original_link_query={this.state.original_link_query}
                                state_governors_query={this.state.state_governors_query}
                            />
                        </div>
                    </div>
                </div>
                <div className="row">
                    <div className="col-md-12">
                        <PostTable
                            handleSearch={this.handleSearch}
                            posts={this.state.posts}
                            query={this.state.query}
                            name_query={this.state.name_query}
                            surname_query={this.state.surname_query}
                            account_query={this.state.account_query}
                            post_query={this.state.post_query}
                            link_query={this.state.link_query}
                            from_query={this.state.from_query}
                            to_query={this.state.to_query}
                            industry_query={this.state.industry_query}
                            state_governors_query={this.state.state_governors_query}
                            federal_legislators_query={this.state.federal_legislators_query}
                            original_link_query={this.state.original_link_query}
                            federal_agency_query={this.state.federal_agency_query}
                        />
                    </div>
                </div>
            </div>
        )
    }
});
