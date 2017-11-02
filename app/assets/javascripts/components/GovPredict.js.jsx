
var GovPredict = createReactClass({
    getInitialState: function() {
        return { posts: [],
            query: null,
            name_query: null,
            surname_query: null,
            account_query: null,
            post_query: null};
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
                           post_query) {
        this.setState((prevState) => {
            return {posts: prevState.posts != posts ? posts : prevState.posts,
                    query: prevState.query != query ? query : prevState.query,
                    name_query: prevState.name_query != name_query ? name_query : prevState.name_query,
                    surname_query: prevState.surname_query != surname_query ? surname_query : prevState.surname_query,
                    account_query: prevState.account_query != account_query ? account_query : prevState.account_query,
                    post_query: prevState.post_query != post_query ? post_query : prevState.post_query
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
                        <SearchForm handleSearch={this.handleSearch}
                                    name_query={this.state.name_query}
                                    surname_query={this.state.surname_query}
                                    account_query={this.state.account_query}
                                    post_query={this.state.post_query}
                        />
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
                        />
                    </div>
                </div>
            </div>
        )
    }
});