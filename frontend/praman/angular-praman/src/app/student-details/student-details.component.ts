import { Component, OnInit } from '@angular/core';
import { Router , ActivatedRoute } from '@angular/router';
import { HttpClient, HttpHeaders } from '@angular/common/http';

@Component({
  selector: 'app-student-details',
  templateUrl: './student-details.component.html',
  styleUrls: ['./student-details.component.css']
})
export class StudentDetailsComponent implements OnInit {

  url;
  address;
  studentName;
  academicRecord = <any>[];
  ipfsUrl: string;
  getStudentRecordsURL = "https://beta-api.ethvigil.com/v1.0/contract/0x45143d7258e5652bc9a85c0db202a8700f642cd7/getStudent/";
  constructor(private route : Router,private activatedRoute: ActivatedRoute,private httpClient: HttpClient) { }

  ngOnInit(): void {
    this.ipfsUrl = 'https://ipfs.io/ipfs/';
    this.address = localStorage.getItem('address');
    this.url = "https://goerli.etherscan.io/" + this.address;
    this.studentName = this.activatedRoute.snapshot.paramMap.get('name');
    this.httpClient.get<any>(this.getStudentRecordsURL+this.address).subscribe((data)=>{
      data.data[0].academicRecord.forEach(element => {
        this.academicRecord.push(element); 
      });
      this.academicRecord.forEach(element => {
        const ipfs = element[2];
        this.httpClient.get<any>(this.ipfsUrl + ipfs).subscribe((res)=>{
          element.push(res.details);
          var image = new Image();
          image.src = res.image;
          element.push(image.src);
        })
      })
    })
  }

  logout(){
    this.route.navigate(["/login/student"]);
    localStorage.clear();
  }

  addActivityRoute(){
    this.route.navigate(["student",this.studentName,"addavtivity"]);
  }

}
