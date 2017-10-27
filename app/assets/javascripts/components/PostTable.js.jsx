
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
                    <th className="col-md-1">Name</th>
                    <th className="col-md-2">Surname</th>
                    <th className="col-md-1">Account</th>
                    <th className="col-md-2">Post</th>
                    <th className="col-md-2">Posted at</th>
                    <th className="col-md-2">Link</th>
                    <th className="col-md-2">Original Link</th>
                </tr>
                </thead>
                <tbody>{posts}</tbody>
            </table>
        )
    }
});