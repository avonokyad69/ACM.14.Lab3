package ST20;
use strict; 
use CGI;
use DBI;

my $n = new CGI;
my $student;
my $selfurl = "lab3.cgi";
my $dbh; 



sub st20
{
    my ($q, $global) = @_;
    $student = $global->{student};
	print "Content-type: text/html; charset=windows-1251\n\n";

	ShowHeader ();
		
	my %MENU = ('doedit' => \&DoEdit,
				'dodelete' => \&DoDelete,
				'edit' => \&Edit);

	my $type =  $n->param("type");

	if($MENU{$type})
	{
		$MENU{$type}->();
	}
	
	ShowList();	
	ShowFooter ();
	

}
#$dbh -> disconnect();
sub ShowHeader
{
	print <<ENDOFHTML;
<html>
<head>
</head>
<body>
<h1>List of regions</h1>
ENDOFHTML
}

sub ShowList
{
	$dbh  =   DBI->connect("DBI:mysql:db;localhost:8889", "root", "root", {RaiseError=>1, AutoCommit=>1});
	ShowForm() unless ($n->param('type') eq 'edit');

	print <<STARTLIST;
	
<table cellspacing>
<tr>
<td width = 255 bgcolor = #F0F8FF> 
<strong>Region</strong> </td>
<td width = 247 bgcolor = #F0F8FF>
<strong>Department</strong> </td>
<td width = 80 bgcolor = #F0F8FF> 
<strong>Employee</strong> </td>
<td width = 1 bgcolor = #F0F8FF> 
<strong>Praepostor</strong> </td>
</tr>
STARTLIST

	my $sth = $dbh->prepare("select * from areas");
	$sth->execute();

	while(my $item = $sth->fetchrow_hashref)
	{
		PrintItem($item);
	}

	$sth->finish();
	
	print '</table>';
	$dbh -> disconnect();
}

sub ShowForm
{
	my ($item) = @_;
	my $checked = "checked" if ($item->{Prpost});
	
	print <<ENDOFFORM;	
<table>
<tr>
<form action = $selfurl method = "post">
<input type = "hidden" name = "student" value = $student/>
<td width > 
<input required type = "text" name = "Region" size = 29 maxlength = 160 value = "$item->{Region}" > </td>
<td width >
<input required type = "text" name = "Department" size = 29 maxlength = 30 value = "$item->{Department}"></td>
<td width > 
<input required type = "number" name = "Employee" min = 15 max = 99 size = 10 maxlength = 2 value = $item->{Employee}></td>
<td width = 100> 
<input type = "checkbox" name = "Prpost"  $checked value = 1 > Praepostor </td>
<input type = "hidden" name = "type" value = "doedit">
<input type = "hidden" name = "id" value = $item->{id}>
<td width = 50> 
<input type = "submit" width = 40 value = "+"</td>
</tr>
</table>
</form>
ENDOFFORM
}

sub PrintItem
{
	my ($item) = @_;
	
	my $Prpost =  "Yes" if ($item->{Prpost});
	
	print <<ENDOFITEM;
<p align=left>

<tr>
<td width  bgcolor = #F0F8FF> 
$item->{Region}</td>
 
<td width  bgcolor = #F0F8FF> 
$item->{Department}</td> 

<td width  bgcolor = #F0F8FF> 
$item->{Employee} </td >
<td width bgcolor = #F0F8FF align = center> $Prpost </td>
<td>
<form action = $selfurl method = post>
<input type = "hidden" name = "student" value = $student/>
<input type = "hidden" name = "type" value = "dodelete">
<input type = "hidden" name = "id" value =  $item->{id}>
<input type = "submit" value = "-"></td>
</form>
<td width = 100 >
<form action = $selfurl method = post>
<input type = "hidden" name = "student" value = $student/>
<input type = "hidden" name = "type" value = "edit">
<input type = "hidden" name = "id"   value =  $item->{id}>
<input type = "submit" value = "Edit"></td>
</form>
</tr>

ENDOFITEM
}

sub DoEdit
{
	$dbh  =   DBI->connect("DBI:mysql:db;localhost:8889", "root", "root", {RaiseError=>1, AutoCommit=>1});
	my $id =$dbh->prepare("select count(*) from areas");
	$id->execute();
	$id++;
	my $Prpost = 0 + $n->param('Prpost');
	my $Employee = 0 + $n->param('Employee');

	my $Region = $dbh->quote($n->param('Region'));
	my $Department = $dbh -> quote ($n->param('Department'));
		
	$dbh->do("replace into areas values($id, $Region, $Department, $Employee, $Prpost)");
	$dbh -> disconnect();
}

sub DoDelete
{
	$dbh  =   DBI->connect("DBI:mysql:db;localhost:8889", "root", "root", {RaiseError=>1, AutoCommit=>1});
	my $id = 0+$n->param('id');
	$dbh -> do ("delete from areas where id = $id");
	$dbh -> disconnect();
}

sub Edit
{
	$dbh  =   DBI->connect("DBI:mysql:db;localhost:8889", "root", "root", {RaiseError=>1, AutoCommit=>1});
	my $id = 0+$n->param('id');
	ShowForm(GetItem(0+$n->param('id')));
	$dbh->do("delete from areas where id=$id");
	$dbh -> disconnect();
	
}

sub GetItem 
{
	my ($id) = @_;
	my $sth = $dbh->prepare("select * from areas where id=$id");
	$sth->execute();

	if(my $item = $sth->fetchrow_hashref)
	{
		return $item;
	}
	$sth->finish();
	my $item = {id => $id};
	
	return $item;
}

sub ShowFooter
{
	print <<ENDOFHTML;
</body>
</html>
ENDOFHTML
}


return 1;
