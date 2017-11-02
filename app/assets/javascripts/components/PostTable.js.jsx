
var PostTable = createReactClass({
    render: function() {
        var posts = [];
        this.props.posts.forEach(function(post) {
            posts.push(<Post post={post}
                               key={'post' + post.id}/>);
        }.bind(this));
        return(
            <table className="table table-striped">
                <thead>
                <tr>
                    <th className="col-md-1">
                        <div>Name</div>
                        <div><NameSearchForm
                                handleSearch={this.props.handleSearch}
                                query={this.props.query}
                                surname_query={this.props.surname_query}
                                account_query={this.props.account_query}
                                post_query={this.props.post_query}/>
                        </div>
                    </th>
                    <th className="col-md-2">
                        <div>Surname</div>
                        <div>
                            <SurnameSearchForm
                                handleSearch={this.props.handleSearch}
                                query={this.props.query}
                                name_query={this.props.name_query}
                                account_query={this.props.account_query}
                                post_query={this.props.post_query}/>
                        </div>
                    </th>
                    <th className="col-md-1">
                        <div>Account</div>
                        <div>
                            <AccountSearchForm
                                handleSearch={this.props.handleSearch}
                                query={this.props.query}
                                name_query={this.props.name_query}
                                surname_query={this.props.surname_query}
                                post_query={this.props.post_query}/>
                        </div>
                    </th>
                    <th className="col-md-2">
                        <div>Post</div>
                        <div>
                            <PostSearchForm
                                handleSearch={this.props.handleSearch}
                                query={this.props.query}
                                name_query={this.props.name_query}
                                surname_query={this.props.surname_query}
                                account_query={this.props.account_query}/>
                        </div>
                    </th>
                    <th className="col-md-2">
                        Posted at
                    </th>
                    <th className="col-md-2">
                        Link
                    </th>
                    <th className="col-md-2">
                        Original Link
                    </th>
                </tr>
                </thead>
                <tbody>{posts}</tbody>
            </table>
        )
    }
});