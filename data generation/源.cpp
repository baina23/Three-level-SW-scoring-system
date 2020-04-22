#include <iostream>
#include <cstdio>
#include<stdlib.h>
#include <string>
#include <algorithm>
#include <vector>
#include <time.h>
#include<math.h>
#include<bitset>
#include <streambuf>
#include <fstream>
#include <cstring>
using namespace std;

/*int trans(char x)
{
	switch (x) {
	case('A'):return(0);
	case('C'):return(1);
	case('G'):return(2);
	case('T'):return(3);
	default:return(5);
	}
}

int main(void)
{
	char s[252];
	cin >> s;
	for (int i = 0; i < 126; i++)
		cout << bitset<2>(trans(s[i]));
}
*/

char trans(int x)
{
	switch (x) {
	case(0):return('A');
	case(1):return('C');
	case(2):return('G');
	case(3):return('T');
	default:return(' ');
	}

}

int main(void)
{
	srand((int)time(0));
	int e_add, e_del, e_sub;
	int num, seq_num, mis_loc, Out1, Out2;
	int len = 0;

	/*typedef struct error_ptr {
		int site;
		int type;
	}Error_ptr;*/
	cout << "输入替换类型错误个数";
	cin >> e_sub;
	cout << "输入增添类型错误个数";
	cin >> e_add;
	cout << "输入缺失类型错误个数";
	cin >> e_del;
	cout << "批量生成错误序列数：";
	cin >> seq_num;
	cout << "输入序列长度";
	cin >> len;
	//Error_ptr* e_ptr = new Error_ptr[len];
	//int** error_site = new int*[e_sub + e_add + e_del];
	ofstream loc("location.txt");
	int** error_site = new int* [seq_num];
	for (int j = 0; j < seq_num; j++) {
		error_site[j] = new int[e_sub + e_add + e_del];
	}
	for (int j = 0; j < seq_num; j++) {
		error_site[j][0] = rand() % (len - 7);
		//int indx = 0;
		for (int i = 1; i < e_add + e_del + e_sub; i++)
		{
			int indx = 0;
			do {
				indx = 0;
				error_site[j][i] = rand() % (len - 7);
				for (int k = 0; k < i; k++) {
					indx |= (error_site[j][i] == error_site[j][k]);
				}
			} while (indx);
		}
		for (int i = 0; i < e_add + e_del + e_sub; i++) {
			if (i == 0) { loc << "del:"; }
			if (i == e_del) { loc << "\t\tadd:"; }
			if (i == e_del + e_add) { loc << "\t\tsub:"; }
			loc << error_site[j][i] << ' ';
		}
		loc << endl;
	}

	//将错误坐标输出到stdprint
	for (int j = 0; j < seq_num; j++) {
		for (int i = 0; i < e_sub + e_add + e_del; i++) {
			cout << int(error_site[j][i]);
			cout << ' ';
		}
		cout << endl;
	}


	//打开文件，随机生成碱基序列
	int* read = new int[len];
	int* temp = new int[len];
	for (int i = 0; i < len; i++)
	{
		num = rand() % 4;
		read[i] = num;
	}

	ofstream err("error.txt");
	ofstream seq("sequence.txt");
	ofstream reference("ref.txt");
	ofstream reads("read.txt");
	for (int k = 0; k < len; k++) {
		Out1 = trans(read[k]);
		cout << char(Out1);
		seq << char(Out1);
		reference<< char(Out1);
		err << bitset<2>(read[k]);
	}
	err << endl;
	cout << endl;
	seq << endl;
	reference << endl;


	//按照坐标生成错误
	for (int j = 0; j < seq_num; j++) {
		memcpy(temp, read, len * sizeof(int));
		for (int i = 0; i < e_del; i++) {//再生成缺失的错误；
			for (int k = 0; k < e_del + e_add + e_sub; k++) {
				if (error_site[j][i] < error_site[j][k]) error_site[j][k] -= 1;
			}
			memcpy(temp + error_site[j][i], temp + error_site[j][i] + 1, (len - error_site[j][i] - 1) * sizeof(int));
			temp[len - 1] = (read[len - 1] + 1) % 4;
		}		
		
		for (int i = e_del; i < e_del + e_add; i++) {//最后是增添的错误；
			for (int k = e_del; k < e_del + e_add + e_sub; k++) {
				if (error_site[j][i] < error_site[j][k]) error_site[j][k] += 1;
			}
			memcpy(temp + error_site[j][i] + 1, temp + error_site[j][i], (len - error_site[j][i] - 1) * sizeof(int));
			temp[error_site[j][i]] = (temp[error_site[j][i]] + 1) % 4;
		}
		for (int i = e_del + e_add; i < e_del + e_add + e_sub; i++) {//为了方便，首先生成替换错误；
			temp[error_site[j][i]] = (temp[error_site[j][i]] + rand() % 3 + 1) % 4;
		}
		//一个错误序列生成完毕，输出到文件流中
		for (int k = 0; k < len; k++)
		{
			Out2 = trans(temp[k]);
			cout << char(Out2);
			seq << char(Out2);
			reads << char(Out2);
			err << bitset<2>(temp[k]);
		}
		err << endl;
		cout << endl;
		seq << endl;
		reads << endl;
	}//seq_num个错误序列全部生成完毕；



	system("pause");

}
