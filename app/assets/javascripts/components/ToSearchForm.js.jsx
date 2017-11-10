
var ToSearchForm = createReactClass({
    componentDidMount() {
        $(this.refs.to_query).datepicker({dateFormat: "yy-mm-dd",
            onSelect: function() {
                $(this).focus();
                $(this).nextAll('input, button, textarea, a').filter(':first').focus();
            }
        });
    },
    componentWillUnmount() {
        $(this.refs.to_query).datepicker('destroy');
    },
    handleSearch: function() {
        var to_query = ReactDOM.findDOMNode(this.refs.to_query).value;
        var query = this.props.query;
        var name_query = this.props.name_query;
        var surname_query = this.props.surname_query;
        var post_query = this.props.post_query;
        var link_query = this.props.link_query;
        var original_link_query = this.props.original_link_query;
        var account_query = this.props.account_query;
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
                    original_link_query: original_link_query,
                    from_query: from_query,
                    to_query: to_query},
            success: function(posts) {
                self.props.handleSearch(posts,
                    query,
                    name_query,
                    surname_query,
                    account_query,
                    post_query,
                    link_query,
                    original_link_query,
                    from_query,
                    to_query);
            },
            error: function(xhr, status, error) {
                alert('Search error: ', status, xhr, error);
            }
        });
    },
    render: function() {
        return(
            <input onSelect={ this.handleSearch }
                   type="text"
                   className="form-control"
                   placeholder="To..."
                   ref="to_query"
                   id="date_picker2"/>
        )
    }
});
