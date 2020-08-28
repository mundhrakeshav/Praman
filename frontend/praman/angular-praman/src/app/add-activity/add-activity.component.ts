import { Component, OnInit } from '@angular/core';
import { Location } from '@angular/common';
import { FormBuilder, Validators, FormGroup, FormControl } from '@angular/forms';
import { HttpClient } from '@angular/common/http';

@Component({
  selector: 'app-add-activity',
  templateUrl: './add-activity.component.html',
  styleUrls: ['./add-activity.component.css'],
})
export class AddActivityComponent implements OnInit {
  public addActivityForm: FormGroup;
  url;
  base64Code = <any>[];
  address;
  token;
  constructor(private location: Location, private formBuilder: FormBuilder,private httpClient: HttpClient) {}

  ngOnInit(): void {
    this.address = localStorage.getItem('address');
    this.token = localStorage.getItem('token');
    // console.log(this.token);
    this.addActivityForm = this.formBuilder.group({
      title: ['', [Validators.required]],
      details: ['', [Validators.required]],
      orgainzationID: ['', [Validators.required]],
      gpa: ['', [Validators.required]],
    });
  }

  goBack() {
    this.location.back();
  }
  onSelectFile(event) {
    // called each time file input changes
    if (event.target.files && event.target.files[0]) {
      var reader = new FileReader();

      reader.readAsDataURL(event.target.files[0]); // read file as data url
      this.encodeImageFileAsURL(event.target.files[0]);
      reader.onload = (event) => {
        // called once readAsDataURL is completed
        this.url = event.target.result;
      };
    }
  }
  onSubmit() {
    const formData = {};
    formData['image'] = this.base64Code[0];
    formData['title'] =  this.addActivityForm.get('title').value
    formData['details'] =  this.addActivityForm.get('details').value
    formData['orgainzationID'] = this.addActivityForm.get('orgainzationID').value
    formData['gpa'] =  this.addActivityForm.get('gpa').value
    formData['address'] = this.address
    formData['token'] = this.token
    console.log(formData)
    this.httpClient.post<any>("http://localhost:5000/addAcademicRecord",formData).subscribe((data)=>{
      (err) => {
        console.log(err);
      }
    });
    this.addActivityForm.reset()
  }
  encodeImageFileAsURL(element) {
    var file = element;
    var temp = [];
    var reader = new FileReader();
    reader.onloadend = function () {
      temp.push(reader.result);
      // console.log('RESULT', reader.result);
    }
    this.base64Code = temp;
    reader.readAsDataURL(file);
  }
}
