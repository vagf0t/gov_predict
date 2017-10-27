var Post = createReactClass({
  propTypes: {
    name: PropTypes.string,
    surname: PropTypes.string,
    account: PropTypes.string,
    content: PropTypes.string,
    posted_at: PropTypes.string,
    url: PropTypes.string,
    original_url: PropTypes.string
  },

  render: function() {
    return (
      <tr>
        <td>{this.props.post.name}</td>
        <td>{this.props.post.surname}</td>
        <td>{this.props.post.account}</td>
        <td>{this.props.post.content}</td>
        <td>{this.props.post.posted_at}</td>
        <td>{this.props.post.url}</td>
        <td>{this.props.post.original_url}</td>
      </tr>
    )
  }
});

