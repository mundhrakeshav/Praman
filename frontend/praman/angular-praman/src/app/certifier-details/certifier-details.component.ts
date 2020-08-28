import { Component, OnInit } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { HttpClient, HttpHeaders } from '@angular/common/http';

@Component({
  selector: 'app-certifier-details',
  templateUrl: './certifier-details.component.html',
  styleUrls: ['./certifier-details.component.css'],
})
export class CertifierDetailsComponent implements OnInit {
  url;
  address;
  token;
  certifierName;
  result = [];
  ipfsUrl: string;
  constructor(
    private route: Router,
    private activatedRoute: ActivatedRoute,
    private httpClient: HttpClient
  ) {}

  ngOnInit(): void {
    this.ipfsUrl = 'https://ipfs.io/ipfs/';
    this.address = localStorage.getItem('address');
    this.token = localStorage.getItem('token');
    console.log('address', this.address);
    console.log('token', this.token);
    this.getPendingRecords();
  }

  approveDocument(item) {
    var formData = {};
    formData['token'] = this.token;
    formData['address'] = item.userAddress;
    formData['requestRecordCount'] = item.requestRecordCount;
    formData['index'] = item.index;
    formData['isApproved'] = 'true';
    this.httpClient
      .post('http://localhost:5000/validateAcademicRecord', formData)
      .subscribe((data) => {});
    setTimeout(() => {
      this.getPendingRecords();
    },1000);
  }
  rejectDocument(item) {
    var formData = {};
    formData['token'] = this.token;
    formData['address'] = item.userAddress;
    formData['requestRecordCount'] = item.requestRecordCount;
    formData['index'] = item.index;
    formData['isApproved'] = 'false';
    this.httpClient
      .post('http://localhost:5000/validateAcademicRecord', formData)
      .subscribe((data) => {});
    setTimeout(() => {
      this.getPendingRecords();
    }, 200);
  }

  logout() {
    this.route.navigate(['/login/certifier']);
    localStorage.clear();
  }

  getPendingRecords() {
    this.url = 'https://goerli.etherscan.io/' + this.address;
    this.certifierName = this.activatedRoute.snapshot.paramMap.get('name');
    const headers = new HttpHeaders().set('address', this.address);
    this.httpClient
      .get<any>('http://localhost:5000/getPendingReqs', { headers })
      .subscribe((data) => {
        if (data.length == 0) {
          this.result = [];
        } else {
          this.result = data;
          this.result.forEach((element) => {
            const ipfs = element.ipfsHash;
            this.httpClient.get<any>(this.ipfsUrl + ipfs).subscribe((data) => {
              element['details'] = data.details;
              var image = new Image();
              image.src = data.image;
              element['image'] = image.src;
            });
          });
          for (var x in this.result) {
            this.result[x]['index'] = x;
          }
        }
      });
  }
}
