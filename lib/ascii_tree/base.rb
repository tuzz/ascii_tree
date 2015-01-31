module AsciiTree
  def self.parse(string)
    string        = CommentStripper.strip(string)
    words         = WordParser.parse(string)
    edges         = EdgeParser.parse(string)
    relationships = RelationshipsBuilder.build(words, edges)

    NodeBuilder.build(relationships)
  end
end
