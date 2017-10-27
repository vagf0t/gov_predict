
var GovPredict = createReactClass({
    getInitialState: function() {
        return { posts: [] };
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
    handleSearch: function(posts) {
        this.setState({ posts: posts });
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
                        <SearchForm handleSearch={this.handleSearch} />
                    </div>
                </div>
                <div className="row">
                    <div className="col-md-12">
                        <PostTable posts={this.state.posts}/>
                    </div>
                </div>
            </div>
        )
    }
});