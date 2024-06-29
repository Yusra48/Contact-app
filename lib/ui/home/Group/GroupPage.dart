import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'Groupviewmodel.dart';

class GroupsView extends StatelessWidget {
  const GroupsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<GroupsViewModel>.reactive(
      viewModelBuilder: () => GroupsViewModel(),
      onModelReady: (viewModel) => viewModel.loadGroups(),
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey[50],
            title: Text(
              'Groups',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  letterSpacing: 1),
            ),
          ),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 300,
                  ),
                  child: GridView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.all(16),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: viewModel.groups.length,
                    itemBuilder: (context, index) {
                      return _buildGroupCard(viewModel.groups[index]);
                    },
                  ),
                ),
                SizedBox(height: 16),
                _buildNewGroupCard(),
                SizedBox(height: 32),
                Text(
                  'Favourites',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                SizedBox(height: 16),
                _buildFavourites(viewModel),
                SizedBox(height: 16),
                TextButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.add_circle_outline,
                    color: Colors.blue,
                    size: 25,
                  ),
                  label: Text(
                    'Add favourite',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildGroupCard(Group group) {
    return Container(
        height: 180,
        width: 200,
        decoration: BoxDecoration(
            color:
                group.name == "Family" ? Color(0xFFB1F8B3) : Color(0xFFF0ABC3),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                  spreadRadius: 0)
            ]),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Row(
            children: [
              SizedBox(width: 170),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Icon(
                    Icons.supervised_user_circle_rounded,
                    size: 35,
                    color: group.name == "Family" ? Colors.green : Colors.pink,
                  ),
                ),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 100),
                child: Text(
                  group.name,
                  style: TextStyle(
                      color:
                          group.name == "Family" ? Colors.green : Colors.pink,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              SizedBox(height: 2),
              Text(
                '${group.members} members',
                style: TextStyle(
                  color: group.members == 16 ? Colors.green : Colors.pink,
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ]));
  }

  Widget _buildNewGroupCard() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Container(
        width: 200,
        height: 180,
        decoration: BoxDecoration(
            color: Color(0xFF98C8F0),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                  spreadRadius: 0)
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, color: Colors.blue),
            SizedBox(height: 4),
            Text('New group',
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 20)),
          ],
        ),
      ),
    );
  }

  Widget _buildFavourites(GroupsViewModel viewModel) {
    return Column(
      children: viewModel.favourites
          .map(
            (favourite) => ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.grey[600],
                child: Text(
                  favourite.name[0],
                  style: TextStyle(color: Colors.white),
                ),
              ),
              title: Text(
                favourite.name,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              subtitle: Text(
                favourite.label,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              trailing: Icon(Icons.favorite, color: Color(0xFFE07169)),
            ),
          )
          .toList(),
    );
  }
}
