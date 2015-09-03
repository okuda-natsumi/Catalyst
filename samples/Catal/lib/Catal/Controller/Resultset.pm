package Catal::Controller::Resultset;

use strict;
use warnings;
# use Catal::Api::Book;
use parent 'Catalyst::Controller';

=head1 NAME

Catal::Controller::Resultset - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched Catal::Controller::Resultset in Resultset.');
}

sub all :Local {
	my ($self, $c) = @_;
	$c->stash->{list} = [$c->model('CatalDB::Book')->all];
	$c->stash->{template} = 'list.tt';
}

sub find :Local {
  my ($self, $c) = @_;
  $c->stash->{book} = $c->model('CatalDB::Book')->find('978-4-8443-2699-1');
  $c->stash->{template} = 'details.tt';
}

sub find2 :Local {
  my ($self, $c) = @_;
  $c->stash->{book} = $c->model('CatalDB::Book')
    ->find('基礎XML', {key => 'title_key'});
  $c->stash->{template} = 'details.tt';
}

sub where :Local {
  my ($self, $c) = @_;
  $c->stash->{list} = [$c->model('CatalDB::Book')
    ->search( { publish => 'インプレス'} )];
    # ->search( { published => { '>=' => '2009-01-01' } })];
    # ->search( { 'publish' => { 'IN' => ['インプレス', '翔泳社', '秀和システム'] } })];
    # ->search( { 'published' => { 'NOT BETWEEN' => ['2010-10-01', '2010-10-31'] }})];
    # ->search( { 'title' => { 'LIKE' => '%Catalyst%' }})];
    # ->search( { 'title' })];
    # ->search( {'title' => \'IS NOT NULL'})];
    # ->search( {'price' => \'> 3000'})];
    
    # ->search( { publish => 'インプレス', published => {'>' => '2009-01-01'} })];
    # ->search( [{ publish => 'インプレス' }, {published => {'>' => '2009-01-01'}}])];

    # ->search( [
    #   { 
    #     publish => 'インプレス', 
    #     title => {'LIKE' => '%Perl%' }
    #   },
    #   {published => {'>' => '2009-01-01'} }
    # ] )
  # ];

    # ->search( {
    #   publish => 'インプレス',
    #   -nest =>
    #     [
    #       title => {'LIKE' => '%Perl%'},
    #       published => {'>' => '2009-01-01' }
    #     ]
    #   }
    # )
  # ];

    # ->search( { publish => ['インプレス', '翔泳社', '技術評論社'] })];

  $c->stash->{template} = 'list.tt';
}

sub orderby :Local {
  my ($self, $c) = @_;
  $c->stash->{list} = [$c->model('CatalDB::Book')
    ->search({ }, { order_by => { -desc => 'published' } })];
    # ->search({ }, { order_by => { -desc => ['published', 'price'] } })];
    # ->search({ }, { order_by => [ { -desc => 'published'}, { -asc  => 'title'} ] })];
  $c->stash->{template} = 'list.tt';
}

sub rows :Local {
  my ($self, $c, $page) = @_;
  $page = 1 unless $page;
  $c->stash->{list} = [$c->model('CatalDB::Book')
    ->search(undef, {
      order_by => { -desc => ['published', 'price'] },
      rows => 3,
      page => $page
    })];
  $c->stash->{template} = 'list.tt';
}

sub groupby :Local {
  my ($self, $c) = @_;
  $c->stash->{list} = [$c->model('CatalDB::Book')
    ->search(undef, {
      group_by => ['publish'],
      select => ['publish', { AVG => 'price' } ],
      as => ['publish', 'avg_price'],
      # having => { 'AVG(price)' => { '<', 2700 } }
    })];
}

sub distinct :Local {
  my ($self, $c) = @_;
  $c->stash->{list} = [$c->model('CatalDB::Book')
    ->search(undef, {
      select => [ 'publish' ],
      distinct => 1,
    })];
}

sub count :Local {
	my ($self, $c) = @_;
	my $result = $c->model('CatalDB::Book')
		->search({ publish => 'インプレス' })->count;
	$c->response->body("${result}件が検索されました。");
}

sub search_literal :Local {
  my ($self, $c) = @_;
  $c->stash->{list} = [$c->model('CatalDB::Book')
    ->search_literal('(title LIKE ? OR published > ? ) AND publish = ?',
      ('%Perl%', '2009-01-01', 'インプレス'))];
  $c->stash->{template} = 'list.tt';
}

sub get_column :Local {
  my ($self, $c) = @_;
  my $result = $c->model('CatalDB::Book')
    ->search({ publish => 'インプレス' })->get_column('price')->max;
  $c->response->body("最高価格は${result}円です。");
}

sub insert :Local {
  my ($self, $c) = @_;
  my $row = $c->model('CatalDB::Book')->create({
    isbn => '978-4-8443-2699-2',
    title => '基礎Perl2',
    price => 3150,
    publish => 'インプレスジャパン',
    published => \'NOW()'
  });
  $c->response->body('データの登録に成功しました。');
}

sub insert2 :Local {
  my ($self, $c) = @_;
  my $row = $c->model('CatalDB::Book')->new({});
  $row->isbn('978-4-8443-2699-2');
  $row->title('基礎Perl2');
  $row->price(3150);
  $row->publish('インプレスジャパン');
  $row->published(\'NOW()');
  $row->insert();
  $c->response->body('データの登録に成功しました。');
}

sub last_id :Local {
  my ($self, $c) = @_;
  my $row = $c->model('CatalDB::Comment')->create({
    name => 'Y.Yamada',
    body => 'テストです。',
    updated => \'NOW()'
  });
  $c->response->body('最新のID値：' . $row->id);
}

sub update :Local {
  my ($self, $c) = @_;
  my $row = $c->model('CatalDB::Book')->find('978-4-8443-2699-2');
	$row->title('基礎Perl 第2版');
	$row->publish('インプレス');
	$row->update();
  $c->response->body("データを更新できました。");
}

sub update2 :Local {
  my ($self, $c) = @_;
  my $row = $c->model('CatalDB::Book')->search(
    { publish => 'インプレス' }
  );
  $row->update({
    price => \'price * 1.05'
  });
  $c->response->body($row->count . '件を更新しました。');
}

sub delete :Local {
  my ($self, $c) = @_;
  my $result = $c->model('CatalDB::Book')->search(
    {published => { '<' => '2008-01-01' }})->delete();
  $c->response->body("${result}件を削除しました。");
}

sub find_or_new :Local {
  my ($self, $c) = @_;
  my $book = $c->model('CatalDB::Book')->find_or_new({
    isbn => '978-4-8443-2061-7',
    title => '基礎XML 第2版',
    price => 3150,
    publish => 'インプレス',
    published => '2010-04-28'
  });
  if ($book->in_storage) {
    $c->response->body('同一のキーでデータが存在します。');
  } else {
    $book->insert();
    $c->response->body('データを新規に登録しました。');
  }
}

sub update_or_create :Local {
  my ($self, $c) = @_;
  my $review = $c->model('CatalDB::Review')->update_or_new({
    isbn => '978-4-8443-2699-1',
    uid => 'nkakeya',
    body => 'Perlをこれから学びたい人にはお勧めです。基礎がしっかり身に付きます。',
    updated => \'NOW()'
  });
  if ($review->in_storage) {
    $c->response->body("データを更新しました。");
  } else {
    $review->insert();
    $c->response->body("データを登録しました。");
  }
}

sub transaction :Local {
  my ($self, $c) = @_;
  eval {
    $c->model('CatalDB')->schema->txn_do(sub {
      $c->model('CatalDB::Book')->create({
        isbn => '978-4-8443-2699-3',
        title => '基礎Catalyst',
        price => '3360',
        publish => 'インプレス',
        published => '2010-05-12',
      });
      $c->model('CatalDB::Book')->create({
        isbn => '978-4-8443-2699-3',
        title => '基礎Catalyst',
        price => '3360',
        publish => 'インプレス',
        published => '2010-05-12',
      });
    });
  };
  if ($@) {
    if ( $@ =~ /rollback failed/ ) {
      $c->response->body('ロールバックに失敗しました。');
    } else {
      $c->response->body("処理がロールバックされました：$@");
    }
    return;
  }
  $c->response->body('トランザクションは成功しました。');
}

sub relname :Local {
  my ($self, $c) = @_;
  $c->stash->{book} = $c->model('CatalDB::Book')->find('978-4-8443-2699-1');
}

sub related :Local {
  my ($self, $c) = @_;
  my $rs = $c->model('CatalDB::Book')->find('978-4-8443-2699-1');
  $c->stash->{book} = $rs;
  $c->stash->{reviews} = [$rs->search_related('book_review',
    {}, { order_by => { -desc => ['isbn'] } })->all];
    
    # $rs->create_related('book_review', {
    #   uid => 'yyamada',
    #   body => 'おもしろかったです。',
    #   updated => \'NOW()',
    # });
}

sub prefetch :Local {
  my ($self, $c) = @_;
  $c->stash->{list} = [$c->model('CatalDB::Review')
    ->search({ }, {
      prefetch => [ 'book' ],
      rows => 6,
      order_by => { -desc => ['me.updated'] }
    })];
}

sub prefetch2 :Local {
  my ($self, $c) = @_;
  $c->stash->{list} = [$c->model('CatalDB::Book')
    ->search({ }, {
      prefetch => [ 'book_review' ],
      rows => 6,
      order_by => { -desc => ['me.published', 'book_review.updated'] }
    })];
}

sub many :Local {
  my ($self, $c) = @_;
  $c->stash->{list} = [$c->model('CatalDB::Book')
    ->search({ 'me.isbn' => '978-4-8443-2699-1' }, {
      prefetch => { 'book_review' => 'usr' },
      order_by => { -desc => ['book_review.updated'] }
    })];
}

sub many2 :Local {
  my ($self, $c) = @_;
$c->stash->{list} = [$c->model('CatalDB::Review')
  ->search({ 'book.isbn' => '978-4-8443-2699-1' }, {
    prefetch => ['book', 'usr'],
  })];
}

sub join :Local {
  my ($self, $c) = @_;
  $c->stash->{list} = [$c->model('CatalDB::Book')
    ->search({ 'book_review.uid' => 'yyamada' }, {
      join => 'book_review',
      order_by => { -desc => ['book_review.updated'] }
    })];
  $c->stash->{template} = 'list.tt';
}

sub xml_write :Local {
  my ($self, $c) = @_;
  my $row = $c->model('CatalDB::Document')->create({
    docid => 'DC-00',
    doc => { 'name' => 'Catalyst（カタリスト）',
             'content' => "Perl言語によって記述された、Perl環境で動作するアプリケーションフレームワークの一種です。\nPerl環境で利用可能なフレームワークと言った場合、Catalystが唯一の選択肢というわけではありません。\nPerl環境では、実にさまざまなフレームワークが提供されています。" },
    updated => \'NOW()',
  });
  $c->response->body('データの登録に成功しました。');
}

sub xml_read :Local {
  my ($self, $c) = @_;
  $c->stash->{doc} = $c->model('CatalDB::Document')->find('DC-00')->doc;
}

sub dbi :Local {
  my ($self, $c) = @_;
  my $db = $c->model('Catal')->dbh;
  $db->do('set names utf8');
  my $stt = $db->prepare('SELECT * FROM book ORDER BY published DESC');
  $stt->execute();
  my @data = ();
  while(my $row = $stt->fetchrow_hashref()) {
    push @data, $row;
  }
  $c->stash->{list} = \@data;
  $c->stash->{template} = 'list.tt';
}

sub adaptor :Local {
  my ($self, $c) = @_;
  #my $bok = new Catal::Api::Book();
  my $bok = $c->model('BookAdaptor');
  $c->stash->{list} = $bok->getInfosByPublish('インプレス');
  $c->stash->{template} = 'list.tt';
}

sub adaptor2 :Local {
  my ($self, $c) = @_;
  $c->response->body($c->model('DateTimeAdaptor'));
}

=head1 AUTHOR

A clever guy

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
